# EC2 Instances

## Overview

| Instance   | Type     | AMI                     | Subnet  | Role                              |
| ---------- | -------- | ----------------------- | ------- | --------------------------------- |
| Honeypot   | t3.micro | Ubuntu Server 22.04 LTS | Public  | Cowrie + OpenCanary + Filebeat    |
| Bastion    | t3.micro | Ubuntu Server 22.04 LTS | Public  | Jump server                       |
| elk_server | t3.large | Ubuntu Server 22.04 LTS | Private | Elasticsearch + Logstash + Kibana |

## Launch Commands (CLI Example)

```bash
# Honeypot
aws ec2 run-instances \
  --image-id ami-xxxxxxxx \
  --instance-type t3.micro \
  --subnet-id <PUBLIC_SUBNET_ID> \
  --security-group-ids <HONEYPOT_SG_ID> \
  --key-name your-key \
  --associate-public-ip-address \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Honeypot}]'

# Bastion
aws ec2 run-instances \
  --image-id ami-xxxxxxxx \
  --instance-type t3.micro \
  --subnet-id <PUBLIC_SUBNET_ID> \
  --security-group-ids <BASTION_SG_ID> \
  --key-name your-key \
  --associate-public-ip-address \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Bastion}]'

# ELK Server (t3.large — 8 GB RAM required for Elasticsearch)
aws ec2 run-instances \
  --image-id ami-xxxxxxxx \
  --instance-type t3.large \
  --subnet-id <PRIVATE_SUBNET_ID> \
  --security-group-ids <ELK_SG_ID> \
  --key-name your-key \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=elk_server}]'
```

## Connection via Bastion (Jump Server)

```bash
# Connect to the Bastion
ssh -i your-key.pem ubuntu@<BASTION_PUBLIC_IP>

# From the Bastion, connect to the honeypot (admin port 4422)
ssh -p 4422 ubuntu@10.0.1.215

# From the Bastion, connect to the ELK server
ssh ubuntu@10.0.2.10
```

![Honeypot Instance Details](../docs/images/figure-02-instance-honeypot.png)
![Bastion Instance Details](../docs/images/figure-04-instance-bastion.png)
