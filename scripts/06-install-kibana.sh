#!/bin/bash
set -e

sudo apt-get install -y kibana

sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system

sudo systemctl enable kibana
sudo systemctl start kibana
