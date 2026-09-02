#!/bin/bash
set -e

sudo apt-get install -y python3-dev python3-pip libssl-dev \
  libffi-dev build-essential

sudo pip3 install opencanary

opencanaryd --version
opencanaryd --copyconfig

sudo opencanaryd --start
