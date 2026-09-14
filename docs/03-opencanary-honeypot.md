# OpenCanary — Multi-Service Honeypot

## General Overview

OpenCanary is an open-source **multi-protocol honeypot** developed by Thinkst Applied Research. It is a **low-interaction** honeypot based on the **zero false-positive** principle: any traffic received is, by definition, considered malicious.

| Feature             | Details                                                                                   |
| ------------------- | ----------------------------------------------------------------------------------------- |
| GitHub Repository   | https://github.com/thinkst/opencanary                                                     |
| Documentation       | https://opencanary.readthedocs.io                                                         |
| Language            | Python 3 (Twisted)                                                                        |
| Supported Protocols | Up to 14 (FTP, HTTP, MySQL, RDP, SMB, VNC, SSH, SNMP, NTP, Redis, SIP, Telnet, TFTP, Git) |
| Deployed Instance   | i-0330e1658aac4ce4f — 10.0.1.215                                                          |

## Services Enabled in This Project

| Service    | Port     | Observed Result                                                |
| ---------- | -------- | -------------------------------------------------------------- |
| VNC        | 5900/TCP | **796,079 events** over 3 weeks — most scanned service         |
| FTP        | 21/TCP   | Dictionary-based brute-force attempts (admin/admin, anonymous) |
| HTTP Admin | 8080/TCP | Fake administration interface, Nessus/Shodan scans             |
| MySQL      | 3306/TCP | Authentic handshake, root/[empty] login attempts               |

Services **available but not enabled** in this deployment: RDP, SMB, Redis, Git, SIP, TFTP, SNMP, NTP (to limit the exposure surface).

## Cowrie vs OpenCanary Comparison

| Criterion         | Cowrie                                | OpenCanary                                                        |
| ----------------- | ------------------------------------- | ----------------------------------------------------------------- |
| Interaction Type  | Medium (full shell)                   | Low (protocol banners)                                            |
| Protocol Coverage | 2 (SSH + Telnet)                      | Up to 14 simultaneously                                           |
| Analysis Depth    | Very high                             | Low                                                               |
| Data Volume       | Moderate                              | Very high (796k VNC events)                                       |
| Purpose           | Post-exploitation behavioral analysis | Early warning detection                                           |
| False Positives   | Nearly zero                           | Zero (by design)                                                  |
| Complementarity   | Captures **WHAT** the attacker does   | Captures **WHO** is attacking and **WHICH** services are targeted |

## Installation

See `scripts/03-install-opencanary.sh` and `configurations/opencanary/opencanary.conf`
