# Security Groups

## HONEYPOT_SG (sg-0eeb1cfec15f23bb5)

| Type         | Port             | Source       | Justification                        |
| ------------ | ---------------- | ------------ | ------------------------------------ |
| Custom TCP   | 5900 (VNC)       | 0.0.0.0/0    | VNC honeypot                         |
| SSH          | 22               | 0.0.0.0/0    | Brute-force target                   |
| Custom TCP   | 21 (FTP)         | 0.0.0.0/0    | OpenCanary FTP honeypot              |
| Custom TCP   | 2222 (SSH alt)   | 0.0.0.0/0    | Cowrie alternative SSH port          |
| MySQL/Aurora | 3306             | 0.0.0.0/0    | OpenCanary MySQL honeypot            |
| Custom TCP   | 8080 (HTTP)      | 0.0.0.0/0    | Fake administration interface        |
| Custom TCP   | 4422 (SSH admin) | 10.0.1.37/32 | Real admin SSH access — Bastion only |

## BastionSG (sg-000599c7f4080310d)

| Type | Port | Source     | Justification                      |
| ---- | ---- | ---------- | ---------------------------------- |
| SSH  | 22   | YOUR_IP/32 | Admin SSH access only from your IP |

## elkSG (sg-019a54d1addb9ec10)

| Port                  | Source                     | Justification                                                       |
| --------------------- | -------------------------- | ------------------------------------------------------------------- |
| 5044 (Logstash Beats) | Honeypot IP /32            | Filebeat log ingestion                                              |
| 9200 (Elasticsearch)  | Honeypot IP + internal /32 | Elasticsearch API                                                   |
| 22 (SSH)              | Bastion IP /32             | SSH administration                                                  |
| 5601 (Kibana)         | 0.0.0.0/0*                 | *Accessed exclusively through an SSH tunnel (ELK has no public IP)* |

> ⚠️ Replace `YOUR_IP` and the private IP addresses with the actual values from your deployment.
