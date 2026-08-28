#!/bin/bash
# À exécuter depuis votre poste administrateur local
# Usage : ./08-open-kibana-tunnel.sh <IP_BASTION>

BASTION_IP=${1:-"3.221.1.82"}
ELK_PRIVATE_IP="10.0.2.10"

echo "Ouverture du tunnel SSH vers Kibana via la Bastion ($BASTION_IP)..."
ssh -L 5601:${ELK_PRIVATE_IP}:5601 -N ubuntu@${BASTION_IP} &

echo "✅ Tunnel ouvert. Accéder à Kibana sur : http://localhost:5601"
echo "   Pour fermer le tunnel : kill %1"
