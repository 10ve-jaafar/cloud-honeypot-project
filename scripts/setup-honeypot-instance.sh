#!/bin/bash
set -e

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install -y git python3-virtualenv python3-dev \
  libssl-dev libffi-dev build-essential libpython3-dev \
  python3-minimal authbind virtualenv

sudo adduser --disabled-password cowrie

sudo sed -i 's/#Port 22/Port 4422/' /etc/ssh/sshd_config
sudo systemctl restart sshd
