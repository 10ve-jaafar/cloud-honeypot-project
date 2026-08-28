# Security Groups

## HONEYPOT_SG (sg-0eeb1cfec15f23bb5)

| Type | Port | Source | Justification |
|---|---|---|---|
| Custom TCP | 5900 (VNC) | 0.0.0.0/0 | Leurre VNC |
| SSH | 22 | 0.0.0.0/0 | Cible brute-force |
| Custom TCP | 21 (FTP) | 0.0.0.0/0 | Leurre FTP OpenCanary |
| Custom TCP | 2222 (SSH alt) | 0.0.0.0/0 | Port SSH alternatif Cowrie |
| MySQL/Aurora | 3306 | 0.0.0.0/0 | Leurre MySQL OpenCanary |
| Custom TCP | 8080 (HTTP) | 0.0.0.0/0 | Fausse interface admin |
| Custom TCP | 4422 (SSH admin) | 10.0.1.37/32 | SSH admin réel — Bastion uniquement |

## BastionSG (sg-000599c7f4080310d)

| Type | Port | Source | Justification |
|---|---|---|---|
| SSH | 22 | VOTRE_IP/32 | Accès SSH admin uniquement depuis votre IP |

## elkSG (sg-019a54d1addb9ec10)

| Port | Source | Justification |
|---|---|---|
| 5044 (Logstash Beats) | IP Honeypot /32 | Réception logs Filebeat |
| 9200 (Elasticsearch) | IP Honeypot + interne /32 | API Elasticsearch |
| 22 (SSH) | IP Bastion /32 | Administration SSH |
| 5601 (Kibana) | 0.0.0.0/0* | *Accès via tunnel SSH uniquement (ELK n'a pas d'IP publique) |

> ⚠️ Remplacer `VOTRE_IP` et les IPs privées par les valeurs réelles de votre déploiement.
