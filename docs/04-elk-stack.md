# ELK Stack — Rôles, Architecture et Installation

## Vue d'ensemble

La stack ELK constitue le cerveau analytique de l'infrastructure, déployée sur `elk_server` (i-0cd116b18750b48c9 — t3.large — 10.0.2.10) dans le subnet privé.

| Composant | Instance / Port | Rôle | Technologie |
|---|---|---|---|
| Filebeat | Honeypot 10.0.1.215 | Collecte et transport des logs | Go (< 50 MB RAM) |
| Logstash | ELK Server :5044 | Ingestion, parsing, enrichissement | JVM — pipeline ETL |
| Elasticsearch | ELK Server :9200 | Stockage, indexation, recherche | JVM — moteur NoSQL |
| Kibana | ELK Server :5601 | Visualisation, dashboards | Node.js |

Flux unidirectionnel : **Filebeat → Logstash → Elasticsearch → Kibana**

## Elasticsearch

| Caractéristique | Valeur |
|---|---|
| Port API REST | 9200/TCP |
| Index | honeypot-logs-YYYY.MM.dd |
| Politique ILM | 7j hot → 30j warm → suppression auto |
| Heap JVM | 4 GB (t3.large, 8GB RAM) |
| Authentification | xpack.security activée |

→ Installation : `scripts/04-install-elasticsearch.sh`
→ Config : `configurations/elasticsearch/elasticsearch.yml`

## Logstash

Pipeline en 3 étapes : **Input** (beats :5044) → **Filter** (mutate, geoip, date, catégorisation MITRE ATT&CK) → **Output** (elasticsearch).

→ Installation : `scripts/05-install-logstash.sh`
→ Config : `configurations/logstash/honeypot.conf`

## Kibana

Accessible **uniquement via tunnel SSH** depuis la Bastion Host (aucune exposition directe sur Internet) :

```bash
ssh -L 5601:10.0.2.10:5601 ubuntu@3.221.1.82
```

Puis ouvrir `http://localhost:5601` dans le navigateur.

→ Installation : `scripts/06-install-kibana.sh`
→ Config : `configurations/kibana/kibana.yml`

## Filebeat (sur l'instance Honeypot)

Surveille `cowrie.json` et `opencanary.log`, transmet vers Logstash (10.0.2.10:5044) avec un registre garantissant zéro perte / zéro doublon.

→ Installation : `scripts/07-install-filebeat-honeypot.sh`
→ Config : `configurations/filebeat/filebeat.yml`

## Synthèse des flux

| Flux | Source | Destination | Port |
|---|---|---|---|
| Logs Cowrie → Filebeat | Fichier local | Filebeat (10.0.1.215) | Local |
| Filebeat → Logstash | 10.0.1.215 | 10.0.2.10 | 5044/TCP |
| Logstash → Elasticsearch | localhost | localhost | 9200/TCP |
| Admin → Kibana | Navigateur via Bastion | 10.0.2.10 | 5601 (tunnel SSH) |
