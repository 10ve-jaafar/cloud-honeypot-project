# Setup VPC et Subnets

## Création du VPC

```bash
# Via console AWS ou CLI
aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --region us-east-1 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=vpc_honeypot}]'
```

## Subnets

| Subnet | CIDR | AZ | Type |
|---|---|---|---|
| public subnet | 10.0.1.0/24 | us-east-1a | Public (Honeypot + Bastion) |
| private subnet | 10.0.2.0/24 | us-east-1a | Privé (ELK Server) |

```bash
# Subnet public
aws ec2 create-subnet --vpc-id <VPC_ID> --cidr-block 10.0.1.0/24 --availability-zone us-east-1a

# Subnet privé
aws ec2 create-subnet --vpc-id <VPC_ID> --cidr-block 10.0.2.0/24 --availability-zone us-east-1a
```

## Internet Gateway (subnet public)

```bash
aws ec2 create-internet-gateway --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=HONEYPOT-INTERNET-GATEWAY}]'
aws ec2 attach-internet-gateway --vpc-id <VPC_ID> --internet-gateway-id <IGW_ID>
```

## NAT Gateway (subnet privé — accès sortant uniquement)

```bash
# Allouer une Elastic IP
aws ec2 allocate-address --domain vpc

# Créer le NAT Gateway dans le subnet public
aws ec2 create-nat-gateway --subnet-id <PUBLIC_SUBNET_ID> --allocation-id <EIP_ALLOC_ID> \
  --tag-specifications 'ResourceType=natgateway,Tags=[{Key=Name,Value=ELK_Nat_Gateway}]'
```

## Route Tables

**Route table publique** : local + 0.0.0.0/0 → Internet Gateway
**Route table privée** : local + 0.0.0.0/0 → NAT Gateway

![Resource Map](../docs/images/figure-01-resource-map-vpc.png)
