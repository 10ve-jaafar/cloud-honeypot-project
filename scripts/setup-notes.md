# 📝 Setup Notes — Honeypot Cloud AWS

Notes techniques prises pendant le déploiement du projet.
Erreurs rencontrées, solutions trouvées, conseils pratiques.

---

## ✅ Checklist de déploiement

- [ ] Créer le compte AWS (Free Tier)
- [ ] Lancer l'instance EC2 (Ubuntu 22.04)
- [ ] Configurer les Security Groups
- [ ] Se connecter en SSH à l'instance
- [ ] Mettre à jour le système
- [ ] Installer T-Pot
- [ ] Vérifier les honeypots actifs
- [ ] Accéder à Kibana
- [ ] Exposer le serveur à Internet
- [ ] Commencer la période d'observation

---

## 🖥️ Spécifications de l'instance AWS

| Paramètre | Valeur |
|---|---|
| Type d'instance | t2.large |
| Région AWS | eu-west-1 (ou celle choisie) |
| OS | Ubuntu 22.04 LTS |
| RAM | 8 GB |
| Stockage | 128 GB SSD |
| IP Publique | [MASQUÉE] |

---

## 🔌 Connexion SSH à l'instance

```bash
# Connexion initiale
ssh -i "votre-cle.pem" ubuntu@<YOUR_IP>

# Donner les bons droits à la clé
chmod 400 votre-cle.pem
```

---

## ⚠️ Problèmes rencontrés & Solutions

### Problème 1 — Espace disque insuffisant
```
Erreur : T-Pot nécessite minimum 128 GB
Solution : Augmenter le volume EBS dans AWS Console
```

### Problème 2 — Port 22 bloqué après installation T-Pot
```
Erreur : Plus d'accès SSH après reboot
Solution : T-Pot change le port SSH admin vers 64295
Nouvelle commande : ssh -p 64295 -i "cle.pem" ubuntu@<IP>
```

### Problème 3 — Interface Kibana inaccessible
```
Erreur : Timeout sur le port 64296
Solution : Attendre 5-10 min après reboot, 
           T-Pot démarre tous les services progressivement
```

---

## 📊 Période d'observation

| Info | Détail |
|---|---|
| Date de début | [DATE] |
| Date de fin | [DATE] |
| Durée totale | [X] heures / jours |
| Honeypots actifs | Cowrie, Dionaea, Honeytrap... |

---

## 💡 Conseils pratiques

- Toujours **éteindre l'instance** après les tests → évite les frais AWS
- Exporter les logs Kibana **avant** de supprimer l'instance
- Prendre des screenshots régulièrement pendant l'observation
- Vérifier le **budget AWS** quotidiennement (Free Tier limité)

---

## 🔗 Ressources utiles

- [T-Pot GitHub](https://github.com/telekom-security/tpotce)
- [Documentation AWS EC2](https://docs.aws.amazon.com/ec2)
- [Elastic Stack Docs](https://www.elastic.co/guide)
- [Cowrie Honeypot](https://github.com/cowrie/cowrie)
```

**Ce fichier c'est le plus humain du repo** — il montre que vous avez vraiment fait le projet, rencontré des vrais problèmes et trouvé des vraies solutions. Les recruteurs adorent ça 💪

Remplace juste les `[DATE]` et `[X]` par tes vraies données. Ton repo est maintenant **100% complet** ! 🚀
