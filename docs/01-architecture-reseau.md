# AWS Infrastructure Architecture

## Overview — VPC vpc_honeypot

The entire infrastructure is deployed within a dedicated VPC named `vpc_honeypot`, using the CIDR `10.0.0.0/16`, located in the **us-east-1 (N. Virginia)** region.

![VPC Resource Map](./images/figure-01-resource-map-vpc.png)
*Figure 1 - Resource Map of the vpc_honeypot VPC (AWS Console)*

## Network Organization

| Network Component   | Actual Value                              | Role                                              |
| ------------------- | ----------------------------------------- | ------------------------------------------------- |
| VPC                 | vpc_honeypot — 10.0.0.0/16                | Isolated virtual network for the project          |
| Public Subnet       | public subnet — 10.0.1.0/24 — us-east-1a  | Hosts Honeypot + Bastion (Internet-exposed)       |
| Private Subnet      | private subnet — 10.0.2.0/24 — us-east-1a | Hosts ELK Server (not Internet-exposed)           |
| Internet Gateway    | HONEYPOT-INTERNET-GATEWAY                 | Internet access → public subnet                   |
| NAT Gateway         | ELK_Nat_Gateway (Public NAT, 1 EIP)       | Outbound Internet access → private subnet         |
| Public Route Table  | 2 routes (local + IGW 0.0.0.0/0)          | Routes public subnet traffic to the Internet      |
| Private Route Table | 2 routes (local + NAT 0.0.0.0/0)          | Routes private subnet traffic through NAT Gateway |

## Complete Operational Flow

![ELK Pipeline Diagram](./images/figure-08-schema-chaine-elk.png)

*Figure 8 - Complete operational flow of the Elastic Stack in the AWS Honeypot project*

**Diagram overview:** The orange zone (public subnet `10.0.1.0/24`) contains the Cowrie and OpenCanary honeypots, which generate logs on instance `10.0.1.215`. Filebeat collects these logs and sends them via TCP port `5044` to the ELK server.

The blue zone (private subnet `10.0.2.0/24`) contains the ELK components. Logstash receives, parses, and enriches the events (GeoIP, MITRE ATT&CK), then indexes them in Elasticsearch, while Kibana provides visualization.

The analyst accesses Kibana through an SSH tunnel from the Bastion Host, without exposing port `5601` directly to the Internet.
