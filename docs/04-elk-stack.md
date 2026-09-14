# ELK Stack — Roles, Architecture and Installation

## Overview

The ELK Stack serves as the analytical core of the infrastructure, deployed on `elk_server` (i-0cd116b18750b48c9 — t3.large — 10.0.2.10) within the private subnet.

| Component     | Instance / Port     | Role                           | Technology         |
| ------------- | ------------------- | ------------------------------ | ------------------ |
| Filebeat      | Honeypot 10.0.1.215 | Log collection and transport   | Go (< 50 MB RAM)   |
| Logstash      | ELK Server :5044    | Ingestion, parsing, enrichment | JVM — ETL pipeline |
| Elasticsearch | ELK Server :9200    | Storage, indexing, search      | JVM — NoSQL engine |
| Kibana        | ELK Server :5601    | Visualization, dashboards      | Node.js            |

Unidirectional flow: **Filebeat → Logstash → Elasticsearch → Kibana**

## Elasticsearch

| Feature        | Value                                  |
| -------------- | -------------------------------------- |
| REST API Port  | 9200/TCP                               |
| Index          | honeypot-logs-YYYY.MM.dd               |
| ILM Policy     | 7d hot → 30d warm → automatic deletion |
| JVM Heap       | 4 GB (t3.large, 8 GB RAM)              |
| Authentication | xpack.security enabled                 |

→ Installation: `scripts/04-install-elasticsearch.sh`
→ Configuration: `configurations/elasticsearch/elasticsearch.yml`

## Logstash

Three-stage pipeline: **Input** (beats :5044) → **Filter** (mutate, geoip, date, MITRE ATT&CK categorization) → **Output** (Elasticsearch).

→ Installation: `scripts/05-install-logstash.sh`
→ Configuration: `configurations/logstash/honeypot.conf`

## Kibana

Accessible **only through an SSH tunnel** from the Bastion Host (no direct exposure to the Internet):

```bash
ssh -L 5601:10.0.2.10:5601 ubuntu@3.221.1.82
```

Then open `http://localhost:5601` in the browser.

→ Installation: `scripts/06-install-kibana.sh`
→ Configuration: `configurations/kibana/kibana.yml`

## Filebeat (on the Honeypot Instance)

Monitors `cowrie.json` and `opencanary.log`, forwarding logs to Logstash (10.0.2.10:5044) with a registry ensuring zero data loss and zero duplication.

→ Installation: `scripts/07-install-filebeat-honeypot.sh`
→ Configuration: `configurations/filebeat/filebeat.yml`

## Data Flow Summary

| Flow                     | Source              | Destination           | Port              |
| ------------------------ | ------------------- | --------------------- | ----------------- |
| Cowrie Logs → Filebeat   | Local file          | Filebeat (10.0.1.215) | Local             |
| Filebeat → Logstash      | 10.0.1.215          | 10.0.2.10             | 5044/TCP          |
| Logstash → Elasticsearch | localhost           | localhost             | 9200/TCP          |
| Admin → Kibana           | Browser via Bastion | 10.0.2.10             | 5601 (SSH tunnel) |
