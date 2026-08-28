#!/bin/bash
# À exécuter sur l'instance Honeypot (10.0.1.215)

set -e

echo "[1/4] Import clé GPG et ajout du dépôt Elastic..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | \
  sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] \
  https://artifacts.elastic.co/packages/8.x/apt stable main" | \
  sudo tee /etc/apt/sources.list.d/elastic-8.x.list

echo "[2/4] Installation de Filebeat..."
sudo apt-get update
sudo apt-get install -y filebeat

echo "⚠️  Copier configurations/filebeat/filebeat.yml vers /etc/filebeat/"
echo "⚠️  Adapter les IPs (honeypot_instance, public_ip, private_ip, output.logstash.hosts)"

echo "[3/4] Tests avant démarrage..."
sudo filebeat test config -e
sudo filebeat test output

echo "[4/4] Activation du service..."
sudo systemctl enable filebeat
sudo systemctl start filebeat

echo "✅ Filebeat démarré."
echo "   Vérifier réception : curl -u elastic:<PASS> http://<ELK_IP>:9200/honeypot-logs-*/_count"
