# OpenCanary — Honeypot Multi-Services

## Présentation Générale

OpenCanary est un honeypot open-source **multi-protocoles** développé par Thinkst Applied Research, en **low-interaction** avec le principe du **zéro faux positif** : tout trafic reçu est par définition malveillant.

| Caractéristique | Détail |
|---|---|
| Dépôt GitHub | https://github.com/thinkst/opencanary |
| Documentation | https://opencanary.readthedocs.io |
| Langage | Python 3 (Twisted) |
| Protocoles supportés | Jusqu'à 14 (FTP, HTTP, MySQL, RDP, SMB, VNC, SSH, SNMP, NTP, Redis, SIP, Telnet, TFTP, Git) |
| Instance déployée | i-0330e1658aac4ce4f — 10.0.1.215 |

## Services activés dans ce projet

| Service | Port | Résultat observé |
|---|---|---|
| VNC | 5900/TCP | **796 079 événements** en 3 semaines — service le plus scanné |
| FTP | 21/TCP | Brute-force avec dictionnaires (admin/admin, anonymous) |
| HTTP Admin | 8080/TCP | Fausse interface d'administration, scans Nessus/Shodan |
| MySQL | 3306/TCP | Handshake authentique, tentatives root/[vide] |

Services **disponibles mais non activés** dans ce déploiement : RDP, SMB, Redis, Git, SIP, TFTP, SNMP, NTP (pour limiter la surface d'exposition).

## Comparaison Cowrie vs OpenCanary

| Critère | Cowrie | OpenCanary |
|---|---|---|
| Type d'interaction | Moyenne (shell complet) | Basse (bannières protocole) |
| Protocoles couverts | 2 (SSH + Telnet) | Jusqu'à 14 simultanément |
| Profondeur d'analyse | Très élevée | Faible |
| Volume de données | Modéré | Très élevé (796k events VNC) |
| Objectif | Analyse comportementale post-exploitation | Détection précoce (early warning) |
| Faux positifs | Quasi nuls | Nuls (zéro par design) |
| Complémentarité | Capture CE QUE fait l'attaquant | Capture QUI attaque et QUELS services |

## Installation

Voir `scripts/03-install-opencanary.sh` et `configurations/opencanary/opencanary.conf`
