# Sécurité et Considérations Éthiques

## Mesures de Sécurité Implémentées

- **Isolation réseau stricte** : le serveur ELK (10.0.2.10) n'a aucune IP publique
- **Règles egress restrictives** sur HONEYPOT_SG : seul le flux vers 10.0.2.10:5044 est autorisé
- Cowrie exécuté sous un **utilisateur non-privilégié** sans sudo
- **Authentification SSH par clé uniquement**, jamais par mot de passe
- Bastion Host restreinte à **une seule IP source (/32)**
- Accès Kibana **uniquement via tunnel SSH**, jamais exposé directement

## Cadre Éthique et Légal

> Ce projet est réalisé dans un cadre strictement académique sur un compte AWS personnel. Le déploiement d'un honeypot est légal dans cette configuration car l'infrastructure appartient entièrement à l'opérateur. Les données collectées ne sont pas utilisées à des fins commerciales et sont traitées conformément aux principes RGPD. **Aucune contre-attaque n'est effectuée** vers les sources d'attaque identifiées. L'intégration VirusTotal est utilisée en lecture seule à des fins d'analyse académique.

## Défis Techniques Rencontrés

| Défi | Impact | Solution |
|---|---|---|
| Accès Kibana sans IP publique | Interface inaccessible | Tunnel SSH via Bastion |
| Volume de logs massif (796k VNC) | Saturation disque en 48h | Politique ILM Elasticsearch |
| Parsing logs OpenCanary non-JSON | Échec extraction champs | Filtre grok + codec multiline |
| Performances JVM sur t3.large | Latence indexation >5s | Heap JVM fixé à 4GB |
| Port SSH admin exposé | Risque compromission | Déplacé sur port 4422, restreint à la Bastion |

## Perspectives d'Amélioration

- ElastAlert 2 pour alertes automatiques (email/Slack)
- Intégration API VirusTotal v3 directement dans Logstash
- Ajout de Dionaea (capture de malwares)
- Intégration MISP pour corrélation IOC
- Suricata IDS sur le subnet public
- Automatisation Terraform + Ansible
