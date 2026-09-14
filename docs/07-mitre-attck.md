# Attack Phase Analysis — MITRE ATT&CK Correlation

By correlating all Kibana visualizations, the complete attack lifecycle can be reconstructed:

| MITRE ATT&CK Phase | Technique                            | Observed in Kibana               | Evidence                |
| ------------------ | ------------------------------------ | -------------------------------- | ----------------------- |
| Reconnaissance     | T1595.002 — Active Scanning          | 796,079 VNC scans                | Most Targeted Services  |
| Initial Access     | T1110.001 — Password Guessing        | 9,661 attempts                   | Attempted Passwords     |
| Execution          | T1059.004 — Unix Shell               | uname, whoami, cat               | Top Typed Commands      |
| Persistence        | T1098 — Account Manipulation         | chattr -ia .ssh (1,178 times)    | Top Typed Commands #1   |
| Discovery          | T1082 — System Information Discovery | uname -a, lscpu, free -m         | Top Typed Commands #2–7 |
| C2 / Exfiltration  | T1105 — Ingress Tool Transfer        | 12.18% Malware Download          | Threat Categories       |
| Impact             | T1496 — Resource Hijacking           | rm /tmp/secure.sh (crypto miner) | Top Typed Commands #8   |
| Defense Evasion    | T1070.003 — Clear Command History    | unset HISTFILE, history -c       | Long Sessions (9,477s)  |
