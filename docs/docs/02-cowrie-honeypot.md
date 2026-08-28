# Cowrie — Honeypot SSH et Telnet

## Présentation Générale

Cowrie est un honeypot open-source de **moyenne interaction** développé initialement par Michel Oosterhof en 2009 (Kippo), réécrit et renommé Cowrie en 2014.

| Caractéristique | Détail |
|---|---|
| Dépôt GitHub | https://github.com/cowrie/cowrie |
| Documentation | https://cowrie.readthedocs.io |
| Langage | Python 3 (virtualenv dédié) |
| Type d'interaction | Medium-interaction (émulation shell complète) |
| Protocoles supportés | SSH v2 (paramiko) + Telnet |
| Ports dans ce projet | 22/TCP, 2222/TCP (SSH) — 23/TCP (Telnet) |
| Instance déployée | i-0330e1658aac4ce4f — 10.0.1.215 |

## Architecture Interne

| Composant | Rôle | Technologie |
|---|---|---|
| SSH Server | Négocie clés et algorithmes | Paramiko + Twisted |
| Telnet Server | Connexions non chiffrées | Twisted Protocol |
| Shell Emulator | Simule un shell bash interactif | Python — shell.py |
| Filesystem (honeyfs) | Faux système de fichiers Linux | Fichiers statiques |
| Command Handler | Interprète les commandes tapées | Python — commands/ |
| SFTP/SCP Handler | Transferts de fichiers | Paramiko SFTP |
| Output Plugins | JSON, MySQL, Splunk, ELK | Modules output/ |
| Download Catcher | Capture les fichiers téléchargés | urllib + hash |

## Services Simulés

### SSH (Ports 22 et 2222)
Bannière `SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5`, authentification par mot de passe uniquement (clé publique refusée), sessions ASCIINEMA rejouables.

### Telnet (Port 23)
Cible particulièrement les botnets IoT type Mirai qui utilisent Telnet avec des credentials par défaut.

## Système de Credentials — userdb.txt

Voir `configurations/cowrie/userdb.txt`. Format : `username:x:password` où `*` accepte n'importe quel mot de passe.

## Événements JSON produits

| Event ID | Déclencheur |
|---|---|
| cowrie.session.connect | Nouvelle connexion TCP |
| cowrie.login.failed | Échec d'authentification |
| cowrie.login.success | Authentification réussie |
| cowrie.command.input | Commande tapée par l'attaquant |
| cowrie.session.file_download | Fichier téléchargé (wget/curl) |
| cowrie.session.closed | Fin de session (durée en secondes) |

## Installation

Voir `scripts/02-install-cowrie.sh`
