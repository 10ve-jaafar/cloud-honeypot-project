#!/bin/bash
# À exécuter en tant qu'utilisateur "cowrie" sur l'instance Honeypot
# sudo su - cowrie
# bash 02-install-cowrie.sh

set -e

git clone https://github.com/cowrie/cowrie.git
cd cowrie

virtualenv --python=python3 cowrie-env
source cowrie-env/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

cp etc/cowrie.cfg.dist etc/cowrie.cfg

sudo touch /etc/authbind/byport/22
sudo touch /etc/authbind/byport/23
sudo chown cowrie /etc/authbind/byport/22
sudo chown cowrie /etc/authbind/byport/23
sudo chmod 755 /etc/authbind/byport/22
sudo chmod 755 /etc/authbind/byport/23

