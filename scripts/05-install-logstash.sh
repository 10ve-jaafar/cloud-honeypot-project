#!/bin/bash
# À exécuter sur elk_server (10.0.2.10) — après Elasticsearch

set -e

echo "[1/3] Installation de Logstash (dépôt Elastic déjà configuré)..."
sudo apt-get install -y logstash

echo "⚠️  Copier configurations/logstash/honeypot.conf vers /etc/logstash/conf.d/"
echo "⚠️  Remplacer <MOT_DE_PASSE_ELASTIC> dans le fichier de config"

echo "[2/3] Test de la syntaxe du pipeline..."
sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t

echo "[3/3] Activation du service..."
sudo systemctl enable logstash
sudo systemctl start logstash

echo "✅ Logstash installé et démarré."
echo "   Logs live : sudo journalctl -u logstash -f"
