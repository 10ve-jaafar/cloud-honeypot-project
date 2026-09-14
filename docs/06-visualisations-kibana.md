# Kibana Visualizations and Attack Analysis

## honeypot_dashboard — Overview

Accessible at `http://localhost:5601` through the SSH tunnel. Covers 3 weeks of observation (May 2026).

![Dashboard View 1](./images/figure-09-dashboard-1.png)
![Dashboard View 2](./images/figure-10-dashboard-2.png)

## Summary of Actual Collected Metrics

| Metric                           | Value                                         | Source                   |
| -------------------------------- | --------------------------------------------- | ------------------------ |
| OpenCanary Peak (05/22/2026)     | 133,441 events/day                            | Attack Over Time         |
| Total Cowrie Events (05/22/2026) | 4,333 events/day                              | Attack Over Time         |
| Most Targeted Service            | VNC — 796,079 events                          | Most Targeted Services   |
| Password Attempts                | 9,661 attempts                                | Attempted Passwords      |
| Dominant Threat Category         | Reconnaissance — 49.53%                       | Threat Categories        |
| Longest Cowrie Session           | 9,477 seconds (~158 min)                      | Cowrie Session Durations |
| Top Source Countries             | Chile, Hong Kong, Singapore, South Korea, USA | Top IPs                  |
| #1 Malicious IP Detected         | 186.10.86.130 (14/91 vendors)                 | VirusTotal Lookup        |

## 1. Attack Over Time (Cowrie vs OpenCanary)

![Attack Over Time](./images/figure-11-attack-over-time.png)
*Peak on 05/22/2026: 133,441 OpenCanary events, 4,333 Cowrie events*

Cowrie remains relatively stable, representing background botnet activity, while OpenCanary shows a bell-shaped curve typical of an organized VNC scanning campaign.

## 2. Top Source IPs with Geolocation

![Top IPs](./images/figure-12-top-ips.png)

| Source IP      | Country   | City       | VirusTotal Status         |
| -------------- | --------- | ---------- | ------------------------- |
| 186.10.86.130  | Chile     | Las Condes | Malicious — 14/91 vendors |
| 118.26.36.248  | Hong Kong | Hong Kong  | Requires verification     |
| 101.47.156.170 | Singapore | Singapore  | Reappears multiple times  |

## 3. Most Targeted Services

![Most Targeted Services](./images/figure-13-most-targeted-services.png)
*VNC dominates with 796,079 events — more than 95% of OpenCanary traffic*

## 4. Cowrie Session Durations

![Session Durations](./images/figure-14-session-durations.png)
*Maximum session duration: 9,477 seconds (~158 min) — potentially indicating a human attacker or sophisticated bot*

## 5. Attempted Passwords

![Attempted Passwords](./images/figure-15-attempted-passwords.png)

| Rank | Password      | Attempts | Interpretation                 |
| ---- | ------------- | -------- | ------------------------------ |
| 1    | 345gs5662d34  | 1,081    | Custom botnet dictionary       |
| 2    | 3245gs5662d34 | 1,076    | Variant from the same campaign |
| 3    | 123456        | 136      | Most common password           |

## 6. Threat Categories

![Threat Categories](./images/figure-16-threat-categories.png)

| Category             | %      | MITRE ATT&CK  |
| -------------------- | ------ | ------------- |
| Reconnaissance       | 49.53% | T1595 / T1046 |
| Credential Attempt   | 26.1%  | T1110.001     |
| Malware Download     | 12.18% | T1105         |
| Privilege Escalation | 12.18% | T1548 / T1053 |

## 7. Top Typed Commands

![Top Commands](./images/figure-17-top-commands.png)

Most frequently executed command: `cd ~; chattr -ia .ssh; lockr -ia .ssh` (1,178 times) — SSH persistence.

## 8. Alert Severity

![Alert Severity](./images/figure-18-alert-severity.png)
*Peak on May 25, 2026: 64 alerts (9 high, 18 medium, 37 low)*

## 9. OpenCanary Events by Service and IP

![OpenCanary Events](./images/figure-19-opencanary-events.png)

## 10. Integrated VirusTotal Lookup

![VirusTotal](./images/figure-20-virustotal.png)
*IP 186.10.86.130 flagged as malicious by 14/91 vendors (ADMINUSLabs, BitDefender, Fortinet, etc.) — AS27651 ENTEL CHILE S.A.*

Dynamically generated link in Kibana to `https://www.virustotal.com/gui/ip-address/[IP]`.
