# Data Collection and Processing Pipeline

## End-to-End Data Flow

Honeypot (Cowrie JSON + OpenCanary logs)
→ Filebeat (agent on 10.0.1.215)
→ Logstash port 5044 (on 10.0.2.10)
→ Elasticsearch port 9200 (local)
→ Kibana port 5601 (SSH tunnel from Bastion 10.0.1.37)
→ Administrator's Browser

## Enrichment Applied by Logstash

1. **Field Addition**: `honeypot_type`, `honeypot_host_ip`
2. **Timestamp Normalization** (ISO8601 → `@timestamp`)
3. **GeoIP Enrichment**: Geolocation of `src_ip` / `src_host` (city, country, ASN, coordinates)
4. **MITRE ATT&CK Categorization** based on `eventid`:

| Cowrie eventid               | attack_category                |
| ---------------------------- | ------------------------------ |
| cowrie.login.success         | Initial_Access_ValidAccounts   |
| cowrie.login.failed          | Credential_Access_BruteForce   |
| cowrie.command.input         | Execution_CommandLineInterface |
| cowrie.session.file_download | C2_Ingress_Tool_Transfer       |

5. **Data Cleanup**: Removal of unnecessary fields (`agent`, `ecs`, `input`, `log`)

## Example of the Final Enriched Document

```json
{
  "timestamp": "2026-05-22T03:42:17.832543Z",
  "eventid": "cowrie.login.success",
  "src_ip": "186.10.86.130",
  "username": "root",
  "password": "345gs5662d34",
  "attack_category": "Initial_Access_ValidAccounts",
  "honeypot_type": "cowrie",
  "geoip": {
    "country_name": "Chile",
    "city_name": "Las Condes",
    "asn": "AS27651",
    "location": { "lat": -33.4073, "lon": -70.5788 }
  },
  "virustotal_score": "14/91 — Malicious"
}
```

See the complete pipeline in `configurations/logstash/honeypot.conf`.
