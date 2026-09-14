# Security and Ethical Considerations

## Implemented Security Measures

* **Strict network isolation**: the ELK server (`10.0.2.10`) has no public IP address
* **Restrictive egress rules** on `HONEYPOT_SG`: only traffic to `10.0.2.10:5044` is allowed
* Cowrie runs under a **non-privileged user** without sudo access
* **SSH key-based authentication only**, never password-based authentication
* Bastion Host restricted to **a single source IP (/32)**
* Kibana accessible **only through an SSH tunnel**, never directly exposed to the Internet

## Ethical and Legal Framework

> This project was conducted strictly for academic purposes using a personal AWS account. The deployment of a honeypot is lawful in this configuration because the infrastructure is entirely owned and controlled by the operator. The collected data is not used for commercial purposes and is processed in accordance with GDPR principles. **No counterattacks are performed** against identified attack sources. The VirusTotal integration is used in read-only mode for academic analysis purposes.

## Technical Challenges Encountered

| Challenge                            | Impact                          | Solution                                  |
| ------------------------------------ | ------------------------------- | ----------------------------------------- |
| Kibana access without a public IP    | Interface inaccessible          | SSH tunnel through Bastion                |
| Massive log volume (796k VNC events) | Disk saturation within 48 hours | Elasticsearch ILM policy                  |
| Non-JSON OpenCanary logs             | Field extraction failure        | Grok filter + multiline codec             |
| JVM performance on t3.large          | Indexing latency >5s            | JVM heap fixed at 4 GB                    |
| Exposed admin SSH port               | Compromise risk                 | Moved to port 4422, restricted to Bastion |

## Future Improvements

* ElastAlert 2 for automated alerts (email/Slack)
* Direct VirusTotal v3 API integration into Logstash
* Addition of Dionaea for malware capture
* MISP integration for IOC correlation
* Suricata IDS on the public subnet
* Terraform + Ansible automation
