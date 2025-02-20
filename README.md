# NeoGenomics DevOps Test

## Overview
This repo contains:
- **Ansible** (`ansible/`): Configures an EC2 instance to run a simple Flask app with Nginx and Gunicorn.
- **Terraform** (`terraform/`): Defines infrastructure, split into:
  - `vpc/`: Creates the networking setup (VPC, subnets, security groups, etc.).
  - `ec2/`: Deploys an EC2 instance inside the VPC.

## Running the Setup
### **Ansible**
To run the Ansible playbook (after deploying the EC2 instance):
```bash
cd ansible
ansible-playbook -i inventory/aws_ec2.yml playbook.yml
```
This will:
- Install required packages
- Clone and deploy the Flask app
- Set up Gunicorn as a systemd service
- Configure Nginx as a reverse proxy

### **Terraform**
Terraform modules must be applied separately:
```bash
cd terraform/vpc
terraform init && terraform apply

cd ../ec2
terraform init && terraform apply
```
Alternatively, **Terragrunt** could have been used to run both at once while making the state configuration **DRY**, but per the assignment’s request to **keep it simple**, I left that out.

## Pre-commit Hooks
Before committing changes, set up **pre-commit** to enforce style checks:
```bash
pip install pre-commit
pre-commit install
```
This ensures code is formatted and validated before every commit. Ideally,
- **Terrascan** should be added for security scanning.
- **Terratest** should be added for infrastructure testing.

However for this test I only added basic formatting and linting hooks, as well as docs autogeneration for submodules.

## Improving Ansible with Testing
For production setups, **Molecule** could be used for:
- Unit testing playbooks
- Automated linting and validation

This was left out to keep things straightforward but is **recommended** for scalable automation.

