#!/bin/bash
# À exécuter sur l'instance Honeypot (10.0.1.215)

set -e

echo "[1/4] Installation des dépendances système..."
sudo apt-get install -y python3-dev python3-pip libssl-dev \
  libffi-dev build-essential

echo "[2/4] Installation d'OpenCanary via pip..."
sudo pip3 install opencanary

echo "[3/4] Vérification et génération de la config par défaut..."
opencanaryd --version
opencanaryd --copyconfig

echo "⚠️  Remplacer /etc/opencanary.conf par le fichier configurations/opencanary/opencanary.conf"

echo "[4/4] Démarrage d'OpenCanary..."
sudo opencanaryd --start

echo "✅ OpenCanary démarré."
echo "   Vérifier : sudo netstat -tlnp | grep -E ':21|:3306|:5900|:8080'"
echo "   Logs live : sudo tail -f /var/tmp/opencanary.log"
