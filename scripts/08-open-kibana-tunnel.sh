#!/bin/bash

BASTION_IP=${1:-"3.221.1.82"}
ELK_PRIVATE_IP="10.0.2.10"

ssh -L 5601:${ELK_PRIVATE_IP}:5601 -N ubuntu@${BASTION_IP} &
