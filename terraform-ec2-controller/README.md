# AWS EC2 Terraform Controller & Nested Infrastructure Deployment

## Project Overview
This project implements the **Controller / Bastion Pipeline Pattern** using Terraform to deploy an EC2-based Infrastructure-as-Code (IaC) controller instance on AWS. The controller automates the execution of nested Terraform workspaces using temporary security credentials supplied through an attached IAM Instance Profile.

## Architecture Highlights
- **Zero Credentials on Disk**: Authentication is governed via AWS STS using IAM Instance Profiles and IMDSv2.
- **Automated Cloud-Init Bootstrap**: Installs Terraform CLI, configures HashiCorp APT repositories, and prepares `~/secondary-infra`.
- **Dual-Stage Lifecycle**:
  - **Outer Terraform**: Provisions the EC2 runner, security group, IAM instance profile, and SSH key pair.
  - **Nested Terraform**: Executes inside the EC2 controller to provision an S3 bucket with random suffix naming.

## Directory Structure
```
terraform-ec2-controller/
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
├── .gitignore
├── screenshots/
└── Terraform_Assignment_Report.docx
```

## Quick Commands
```bash
# Outer Terraform Workflow
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply

# Connect to Controller
ssh -i ./tf-runner-key.pem ubuntu@<CONTROLLER_PUBLIC_IP>

# Inner Terraform Workflow (on EC2)
cd ~/secondary-infra
terraform init
terraform plan
terraform apply
terraform output

# Teardown Order
# 1. Inside EC2:
terraform destroy -auto-approve
exit

# 2. On Local Machine:
terraform destroy -auto-approve
```
