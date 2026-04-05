# ⚙️ T-Pot Installation Guide

## Prérequis

- Instance AWS EC2 : t2.large minimum
- OS : Ubuntu 22.04 LTS
- RAM : 8 GB minimum
- Stockage : 128 GB SSD
- Accès root ou sudo

---

## Étape 1 — Mettre à jour le système
```bash
sudo apt update && sudo apt upgrade -y
```

## Étape 2 — Cloner T-Pot
```bash
git clone https://github.com/telekom-security/tpotce
cd tpotce
```

## Étape 3 — Lancer l'installation
```bash
sudo ./install.sh --type=user
```

> Choisir le mode **HIVE** pour avoir tous les honeypots actifs

## Étape 4 — Redémarrer le serveur
```bash
sudo reboot
```

## Étape 5 — Accéder aux interfaces

| Interface | URL |
|---|---|
| T-Pot UI | `https://<YOUR_IP>:64297` |
| Kibana | `https://<YOUR_IP>:64296` |
| Attack Map | `https://<YOUR_IP>:64297/map` |

---

## ⚠️ Notes importantes

- Ne jamais partager ton IP publique AWS
- Désactiver l'instance après les tests pour éviter des frais
- Les logs sont stockés dans `/data/`
