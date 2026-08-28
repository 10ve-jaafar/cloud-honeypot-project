#!/bin/bash
# À exécuter sur l'instance Honeypot (10.0.1.215)
# Préparation système et sécurisation de l'accès SSH admin

set -e

echo "[1/4] Mise à jour système..."
sudo apt-get update && sudo apt-get upgrade -y

echo "[2/4] Installation des dépendances..."
sudo apt-get install -y git python3-virtualenv python3-dev \
  libssl-dev libffi-dev build-essential libpython3-dev \
  python3-minimal authbind virtualenv

echo "[3/4] Création utilisateur dédié cowrie (non-privilégié)..."
sudo adduser --disabled-password cowrie

echo "[4/4] Déplacement du SSH admin sur le port 4422 (restreint à la Bastion)..."
sudo sed -i 's/#Port 22/Port 4422/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "✅ Instance Honeypot préparée. SSH admin désormais sur le port 4422."
