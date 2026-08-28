# Analyse des Phases d'Attaque — Corrélation MITRE ATT&CK

En croisant toutes les visualisations Kibana, voici le cycle complet d'attaque reconstitué :

| Phase MITRE ATT&CK | Technique | Observé dans Kibana | Preuve |
|---|---|---|---|
| Reconnaissance | T1595.002 — Active Scanning | 796 079 scans VNC | Most Targeted Services |
| Initial Access | T1110.001 — Password Guessing | 9 661 tentatives | Attempted Passwords |
| Execution | T1059.004 — Unix Shell | uname, whoami, cat | Top Typed Commands |
| Persistence | T1098 — Account Manipulation | chattr -ia .ssh (1 178 fois) | Top Typed Commands #1 |
| Discovery | T1082 — System Info Discovery | uname -a, lscpu, free -m | Top Typed Commands #2-7 |
| C2 / Exfiltration | T1105 — Ingress Tool Transfer | 12,18% Malware Download | Threat Categories |
| Impact | T1496 — Resource Hijacking | rm /tmp/secure.sh (miner crypto) | Top Typed Commands #8 |
| Defense Evasion | T1070.003 — Clear History | unset HISTFILE, history -c | Sessions longues (9 477s) |
