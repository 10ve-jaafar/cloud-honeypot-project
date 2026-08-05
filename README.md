# 🍯 Honeypot Cloud – Détection des Attaques en Temps Réel

<div align="center">

![AWS](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Elastic](https://img.shields.io/badge/Elastic_Stack-005571?style=for-the-badge&logo=elastic&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)

> Déploiement d'un honeypot cloud sur AWS pour capturer et analyser des cyberattaques réelles en temps réel.  
> Mini-projet – 1ère Année Génie Réseaux & Télécommunications | ENSA Safi | 2025/2026

</div>

---

##  Présentation

Ce projet consiste à déployer un **honeypot cloud** sur Amazon Web Services afin d'exposer intentionnellement un serveur à Internet et d'observer les comportements malveillants en temps réel.

L'objectif est d'analyser :
- Les **ports les plus ciblés** par les attaquants
- Les **origines géographiques** des attaques
- Les **techniques utilisées** (bruteforce SSH, scans, etc.)
- Les **patterns automatisés** des bots et malwares

---

##  Aperçu

<!-- Remplace ces lignes par tes vraies captures d'écran -->
| Carte des attaques (Kibana) | Dashboard T-Pot |
|---|---|
| ![attack-map](screenshots/kibana-dashboard.png) | ![tpot](screenshots/tpot-dashboard.png) |

---

##  Stack Technique

| Composant | Rôle |
|---|---|
| **AWS EC2** | Hébergement de l'instance cloud |
| **T-Pot** | Plateforme multi-honeypots (Cowrie, Dionaea, etc.) |
| **Elasticsearch** | Stockage et indexation des logs |
| **Kibana** | Visualisation et dashboards temps réel |
| **Ubuntu Linux** | Système d'exploitation du serveur |

---

##  Architecture

```
Internet (Attaquants)
        │
        ▼
  ┌─────────────┐
  │  AWS EC2    │  ← IP publique exposée
  │  (Ubuntu)   │
  └──────┬──────┘
         │
  ┌──────▼──────┐
  │   T-Pot     │  ← Multi-honeypots (SSH, HTTP, FTP...)
  │             │
  └──────┬──────┘
         │
  ┌──────▼──────────────┐
  │   Elastic Stack     │  ← Logs + Visualisation Kibana
  │ (ES + Kibana)       │
  └─────────────────────┘
```

---

##  Installation & Déploiement

### 1. Créer l'instance AWS EC2
- Type : `t2.large` minimum recommandé
- OS : Ubuntu 22.04 LTS
- Storage : 128 GB SSD
- Ouvrir les ports nécessaires dans le Security Group

### 2. Configurer les Security Groups AWS
```
Port 22    → SSH (accès admin uniquement)
Port 80    → HTTP Honeypot
Port 443   → HTTPS Honeypot
Port 64297 → Interface T-Pot Web UI
Port 64295 → Kibana
Tous les autres ports → ouverts pour attirer les attaquants
```

### 3. Installer T-Pot
```bash
# Cloner le repo T-Pot
git clone https://github.com/telekom-security/tpotce

# Lancer l'installation
cd tpotce
sudo ./install.sh --type=user
```

### 4. Accéder aux dashboards
```
T-Pot UI  : https://<YOUR_IP>:64297
Kibana    : https://<YOUR_IP>:64296
```

---

##  Résultats Obtenus

> Données collectées pendant la période d'observation

-  **+X 000** tentatives d'intrusion détectées
-  Attaques provenant de **+XX pays** différents
-  Port **SSH (22)** et **HTTP (80)** les plus ciblés
-  Présence massive de **bots automatisés** testant des credentials par défaut
-  Pic d'attaques observé entre **[heure]h et [heure]h**

*(Remplace les valeurs par tes vraies statistiques)*

---

##  Structure du Projet

```
honeypot-cloud-aws/
│
├── README.md
├── docs/
│   └── rapport.pdf
├── screenshots/
│   ├── kibana-dashboard.png
│   ├── attack-map.png
│   ├── ssh-stats.png
│   └── aws-console.png
└── config/
    ├── security-groups.md
    └── tpot-setup.md
```

---

##  Avertissement

Ce projet est réalisé dans un cadre **strictement académique et éducatif**.  
Le honeypot a été déployé dans un environnement isolé et contrôlé.  
Ne jamais exposer de systèmes de production sans mesures de sécurité appropriées.

---

##  Auteurs

| Nom | GitHub |
|---|---|
| **Lamnayi Jaafar** | [@username](https://github.com/username) |
| **Khoulid Akram** | [@username](https://github.com/username) |
| **Karbachi Othmane** | [@username](https://github.com/username) |

> Sous la supervision de **Pr. Chahbouni** – ENSA Safi

---

##  Licence

Ce projet est sous licence MIT – voir le fichier [LICENSE](LICENSE) pour plus de détails.
