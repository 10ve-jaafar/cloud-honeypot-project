# 🍯 Déploiement d'un Honeypot Cloud sur AWS
### Capture, Analyse et Visualisation des Cyberattaques via la Stack ELK

Projet académique — 1ère Année Génie Réseaux et Télécommunications
École Nationale des Sciences Appliquées de Safi | Année Universitaire 2025/2026

**Réalisé par :** LAMNAYI JAAFAR · KHOULID AKRAM · KARBACHI OTHMANE
**Sous la supervision de :** Pr. CHAHBOUNI OTHMANE

---

## 🎯 Objectif du projet

Déployer une infrastructure de cybersécurité complète sur **Amazon Web Services (AWS / us-east-1)**, combinant des honeypots (Cowrie + OpenCanary) avec une plateforme centralisée de collecte, d'analyse et de visualisation des données d'attaques via la **stack ELK** (Elasticsearch, Logstash, Kibana) et Filebeat.

## 🏗️ Architecture

Internet ──► Honeypot (Cowrie + OpenCanary) ──► Filebeat ──► Logstash ──► Elasticsearch ──► Kibana
34.231.57.63 / 10.0.1.215 :5044 :9200 :5601 (tunnel SSH)


| Instance | ID | IP Publique | IP Privée | Rôle |
|---|---|---|---|---|
| Honeypot | i-0330e1658aac4ce4f | 34.231.57.63 | 10.0.1.215 | Cowrie + OpenCanary + Filebeat |
| Bastion | i-0142d07f52e78bbcf | 3.221.1.82 | 10.0.1.37 | Jump server admin |
| ELK Server | i-0cd116b18750b48c9 | — (aucune) | 10.0.2.10 | Elasticsearch + Logstash + Kibana |

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
