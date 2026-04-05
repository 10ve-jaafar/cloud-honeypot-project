# 🔒 AWS Security Groups Configuration

## Contexte

Les Security Groups sur AWS agissent comme un pare-feu virtuel.
Dans ce projet, on configure deux types de règles :
- **Ports admin** → accès restreint à notre IP uniquement
- **Ports honeypot** → ouverts à tout Internet pour attirer les attaquants

---

## Règles Inbound (Trafic entrant)

| Port | Protocole | Source | Rôle |
|------|-----------|--------|------|
| 22 | TCP | Votre IP uniquement | SSH Admin |
| 64297 | TCP | Votre IP uniquement | T-Pot Web UI |
| 64296 | TCP | Votre IP uniquement | Kibana Dashboard |
| 80 | TCP | 0.0.0.0/0 | HTTP Honeypot |
| 443 | TCP | 0.0.0.0/0 | HTTPS Honeypot |
| 23 | TCP | 0.0.0.0/0 | Telnet Honeypot |
| 21 | TCP | 0.0.0.0/0 | FTP Honeypot |
| 25 | TCP | 0.0.0.0/0 | SMTP Honeypot |
| 3306 | TCP | 0.0.0.0/0 | MySQL Honeypot |
| 5900 | TCP | 0.0.0.0/0 | VNC Honeypot |
| 0-65535 | TCP/UDP | 0.0.0.0/0 | Capture globale |

---

## Règles Outbound (Trafic sortant)

| Port | Protocole | Destination | Rôle |
|------|-----------|-------------|------|
| All | All | 0.0.0.0/0 | Autoriser tout le trafic sortant |

---

## ⚠️ Règles de sécurité importantes

- Le port **22 (SSH admin)** ne doit JAMAIS être ouvert à `0.0.0.0/0`
- Les ports **64297 et 64296** (interfaces admin) → restreints à votre IP
- Ne jamais exposer vos **credentials AWS** dans le repo
- Toujours **masquer votre IP publique** dans les screenshots

---

## 📌 Schéma simplifié
