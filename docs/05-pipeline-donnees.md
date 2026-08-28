# Pipeline de Collecte et Traitement des Données

## Flux de données — bout en bout

Honeypot (Cowrie JSON + OpenCanary logs)
→ Filebeat (agent sur 10.0.1.215)
→ Logstash port 5044 (sur 10.0.2.10)
→ Elasticsearch port 9200 (local)
→ Kibana port 5601 (tunnel SSH depuis Bastion 10.0.1.37)
→ Navigateur administrateur


## Enrichissement appliqué par Logstash

1. **Ajout de champs** : `honeypot_type`, `honeypot_host_ip`
2. **Normalisation des timestamps** (ISO8601 → @timestamp)
3. **GeoIP** : géolocalisation de `src_ip` / `src_host` (ville, pays, ASN, coordonnées)
4. **Catégorisation MITRE ATT&CK** selon `eventid` :

| eventid Cowrie | attack_category |
|---|---|
| cowrie.login.success | Initial_Access_ValidAccounts |
| cowrie.login.failed | Credential_Access_BruteForce |
| cowrie.command.input | Execution_CommandLineInterface |
| cowrie.session.file_download | C2_Ingress_Tool_Transfer |

5. **Nettoyage** : suppression des champs inutiles (`agent`, `ecs`, `input`, `log`)

## Exemple de document enrichi final

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

Voir le pipeline complet dans `configurations/logstash/honeypot.conf`
