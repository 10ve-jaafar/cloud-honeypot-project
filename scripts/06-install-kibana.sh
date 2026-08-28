#!/bin/bash
# À exécuter sur elk_server (10.0.2.10) — après Elasticsearch

set -e

echo "[1/4] Installation de Kibana..."
sudo apt-get install -y kibana

echo "⚠️  Copier configurations/kibana/kibana.yml vers /etc/kibana/"
echo "⚠️  Remplacer <MOT_DE_PASSE_KIBANA_SYSTEM> et la clé de chiffrement"

echo "[2/4] Génération du token d'enrôlement Kibana → Elasticsearch..."
sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

echo "[3/4] Création du mot de passe kibana_system..."
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system

echo "[4/4] Activation du service..."
sudo systemctl enable kibana
sudo systemctl start kibana

echo "✅ Kibana installé."
echo "   Depuis votre poste : ssh -L 5601:10.0.2.10:5601 -N ubuntu@<IP_BASTION> &"
echo "   Puis ouvrir http://localhost:5601"
echo "   Stack Management → Index Patterns → créer : honeypot-logs-*"
