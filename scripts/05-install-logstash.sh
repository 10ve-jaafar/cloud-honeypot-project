#!/bin/bash
set -e

sudo apt-get install -y logstash

sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t

sudo systemctl enable logstash
sudo systemctl start logstash
