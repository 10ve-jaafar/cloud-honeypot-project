# Cowrie — SSH and Telnet Honeypot

## General Overview

Cowrie is an open-source **medium-interaction honeypot** initially developed by Michel Oosterhof in 2009 (Kippo), rewritten and renamed Cowrie in 2014.

| Feature               | Details                                   |
| --------------------- | ----------------------------------------- |
| GitHub Repository     | https://github.com/cowrie/cowrie          |
| Documentation         | https://cowrie.readthedocs.io             |
| Language              | Python 3 (dedicated virtualenv)           |
| Interaction Type      | Medium-interaction (full shell emulation) |
| Supported Protocols   | SSH v2 (Paramiko) + Telnet                |
| Ports in this project | 22/TCP, 2222/TCP (SSH) — 23/TCP (Telnet)  |
| Deployed Instance     | i-0330e1658aac4ce4f — 10.0.1.215          |

## Internal Architecture

| Component            | Role                                     | Technology         |
| -------------------- | ---------------------------------------- | ------------------ |
| SSH Server           | Negotiates keys and algorithms           | Paramiko + Twisted |
| Telnet Server        | Handles unencrypted connections          | Twisted Protocol   |
| Shell Emulator       | Simulates an interactive bash shell      | Python — shell.py  |
| Filesystem (honeyfs) | Fake Linux filesystem                    | Static files       |
| Command Handler      | Interprets commands entered by attackers | Python — commands/ |
| SFTP/SCP Handler     | Handles file transfers                   | Paramiko SFTP      |
| Output Plugins       | JSON, MySQL, Splunk, ELK                 | output/ modules    |
| Download Catcher     | Captures downloaded files                | urllib + hash      |

## Simulated Services

### SSH (Ports 22 and 2222)

Banner: `SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5`

Password-based authentication only (public key authentication is rejected). Sessions can be replayed using ASCIINEMA.

### Telnet (Port 23)

Particularly targets IoT botnets such as Mirai, which commonly use Telnet with default credentials.

## Credentials System — userdb.txt

See `configurations/cowrie/userdb.txt`.

Format: `username:x:password`, where `*` accepts any password.

## Generated JSON Events

| Event ID                     | Trigger                              |
| ---------------------------- | ------------------------------------ |
| cowrie.session.connect       | New TCP connection                   |
| cowrie.login.failed          | Authentication failure               |
| cowrie.login.success         | Successful authentication            |
| cowrie.command.input         | Command entered by the attacker      |
| cowrie.session.file_download | File downloaded (wget/curl)          |
| cowrie.session.closed        | End of session (duration in seconds) |

## Installation

See `scripts/02-install-cowrie.sh`
