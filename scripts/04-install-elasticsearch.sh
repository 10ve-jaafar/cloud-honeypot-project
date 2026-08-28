#!/bin/bash
# À exécuter sur elk_server (10.0.2.10)

set -e

echo "[1/4] Import de la clé GPG Elastic..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | \
  sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

echo "[2/4] Ajout du dépôt APT Elastic 8.x..."
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] \
  https://artifacts.elastic.co/packages/8.x/apt stable main" | \
  sudo tee /etc/apt/sources.list.d/elastic-8.x.list

echo "[3/4] Installation d'Elasticsearch..."
sudo apt-get update
sudo apt-get install -y elasticsearch

echo "⚠️  Copier configurations/elasticsearch/elasticsearch.yml vers /etc/elasticsearch/"
echo "⚠️  Configurer la heap JVM à 4GB dans /etc/elasticsearch/jvm.options.d/heap.options :"
echo "    -Xms4g"
echo "    -Xmx4g"

echo "[4/4] Activation du service..."
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

echo "✅ Elasticsearch installé. Conservez le mot de passe 'elastic' affiché lors de l'installation !"
echo "   Test : curl -u elastic:<MOT_DE_PASSE> http://localhost:9200"
