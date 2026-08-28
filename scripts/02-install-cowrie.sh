#!/bin/bash
# À exécuter en tant qu'utilisateur "cowrie" sur l'instance Honeypot
# sudo su - cowrie
# bash 02-install-cowrie.sh

set -e

echo "[1/5] Clonage du dépôt Cowrie..."
git clone https://github.com/cowrie/cowrie.git
cd cowrie

echo "[2/5] Création de l'environnement virtuel Python..."
virtualenv --python=python3 cowrie-env
source cowrie-env/bin/activate

echo "[3/5] Installation des dépendances..."
pip install --upgrade pip
pip install -r requirements.txt

echo "[4/5] Copie de la configuration par défaut..."
cp etc/cowrie.cfg.dist etc/cowrie.cfg
echo "⚠️  Remplacer etc/cowrie.cfg et etc/userdb.txt par les fichiers du dossier configurations/cowrie/"

echo "[5/5] Autorisation d'écoute sur les ports privilégiés (authbind)..."
sudo touch /etc/authbind/byport/22
sudo touch /etc/authbind/byport/23
sudo chown cowrie /etc/authbind/byport/22
sudo chown cowrie /etc/authbind/byport/23
sudo chmod 755 /etc/authbind/byport/22
sudo chmod 755 /etc/authbind/byport/23

echo "✅ Cowrie installé. Copier vos fichiers de config puis lancer : bin/cowrie start"
echo "   Vérifier : sudo netstat -tlnp | grep -E ':22|:2222|:23'"
echo "   Logs live : tail -f var/log/cowrie/cowrie.json | python3 -m json.tool"
