# 🍯 Honeypot Cloud – Détection des Attaques en Temps Réel

<div align="center">

![AWS](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Elastic](https://img.shields.io/badge/Elastic_Stack-005571?style=for-the-badge&logo=elastic&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)

> Déploiement d'un honeypot cloud sur AWS pour capturer et analyser des cyberattaques réelles en temps réel.  


</div>


## 🎯 Objectif du projet

Déployer une infrastructure de cybersécurité complète sur **Amazon Web Services (AWS / us-east-1)**, combinant des honeypots (Cowrie + OpenCanary) avec une plateforme centralisée de collecte, d'analyse et de visualisation des données d'attaques via la **stack ELK** (Elasticsearch, Logstash, Kibana) et Filebeat.

## 🏗️ Architecture

![Honeypot Architecture](./images/honeypot.png)

## 🔑 Mots-clés

Honeypot · OpenCanary · Cowrie SSH Honeypot · AWS · Elastic Stack (ELK) · Threat Intelligence · VPC · GeoIP Enrichment · MITRE ATT&CK · Bastion Host · Security Group · Cyber-déception · VirusTotal Lookup


## 📊 Résultats clés (3 semaines d'observation — mai 2026)

- **796 079** scans VNC détectés (service le plus ciblé)
- **133 441** événements OpenCanary en une seule journée (pic du 22/05/2026)
- **9 661** tentatives de mots de passe capturées
- **49,53%** des menaces classées "Reconnaissance" (MITRE ATT&CK)
- IP **186.10.86.130** confirmée malveillante par VirusTotal (14/91 vendors)

## 📁 Structure du dépôt

| Dossier | Contenu |
|---|---|
| `docs/` | Documentation détaillée (architecture, honeypots, ELK, visualisations) |
| `scripts/` | Scripts d'installation bash pour chaque composant |
| `configurations/` | Fichiers de configuration réels (Cowrie, OpenCanary, ELK, Filebeat) |
| `lab-setup/` | Documentation du déploiement AWS (VPC, Security Groups, EC2) |

## 🚀 Démarrage rapide

1. Consulter `lab-setup/` pour reconstituer l'infrastructure AWS (VPC, subnets, Security Groups, instances EC2)
2. Exécuter les scripts dans `scripts/` dans l'ordre numéroté sur les instances correspondantes
3. Copier les fichiers de `configurations/` vers leurs emplacements respectifs
4. Consulter `docs/06-visualisations-kibana.md` pour recréer les dashboards

## ⚠️ Cadre éthique et légal

Projet réalisé dans un cadre strictement académique sur un compte AWS personnel. L'infrastructure appartient entièrement à l'opérateur. Aucune contre-attaque n'est effectuée vers les sources identifiées. Voir `docs/08-securite-ethique.md`.

## 📚 Références

- [Cowrie Documentation](https://cowrie.readthedocs.io)
- [OpenCanary Documentation](https://opencanary.readthedocs.io)
- [Elastic Stack Documentation](https://www.elastic.co/guide/)
- [MITRE ATT&CK Framework](https://attack.mitre.org)

## 📄 Licence

Projet académique — ENSA Safi 2025/2026
