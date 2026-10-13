terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project   = "Terraform-Controller-Lab"
      ManagedBy = "Terraform-Outer"
    }
  }
}

# -----------------------------------------------------------------------------
# 1. IAM ROLE & INSTANCE PROFILE (Allows EC2 to provision AWS resources)
# -----------------------------------------------------------------------------
resource "aws_iam_role" "terraform_runner_role" {
  name = "terraform-controller-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AdministratorAccess (as specified in lab assignment; scoped policy recommended in production)
resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.terraform_runner_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "runner_profile" {
  name = "terraform-controller-instance-profile"
  role = aws_iam_role.terraform_runner_role.name
}

# -----------------------------------------------------------------------------
# 2. AUTOMATED RSA KEY PAIR GENERATION (FOR SSH ACCESS)
# -----------------------------------------------------------------------------
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "tf-runner-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/tf-runner-key.pem"
  file_permission = "0400"
}

# -----------------------------------------------------------------------------
# 3. SECURITY GROUP CONFIGURATION
# -----------------------------------------------------------------------------
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "runner_sg" {
  name        = "terraform-runner-sg"
  description = "Allow inbound SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH administrative ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    description = "Allow outbound traffic for downloading Terraform packages & APIs"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------------------------------------------------------
# 4. AMI LOOKUP & EC2 INSTANCE WITH USER DATA BOOTSTRAP
# -----------------------------------------------------------------------------
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "terraform_runner" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.runner_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.runner_profile.name
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }

  # User data bootstrap: Installs Terraform and prepares secondary infrastructure
  user_data = <<-EOF
              #!/bin/bash
              set -e

              # 1. Update OS and install prerequisites
              export DEBIAN_FRONTEND=noninteractive
              apt-get update -y
              apt-get install -y gnupg software-properties-common curl wget git unzip

              # 2. Add HashiCorp official GPG key and APT repository
              wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
              echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

              # 3. Install Terraform CLI binary
              apt-get update -y
              apt-get install -y terraform

              # 4. Create an infra directory and a sample nested .tf project for ubuntu user
              mkdir -p /home/ubuntu/secondary-infra
              cat <<'INNER_TF' > /home/ubuntu/secondary-infra/main.tf
              terraform {
                required_version = ">= 1.5.0"
                required_providers {
                  aws = {
                    source  = "hashicorp/aws"
                    version = "~> 5.0"
                  }
                  random = {
                    source  = "hashicorp/random"
                    version = "~> 3.0"
                  }
                }
              }

              provider "aws" {
                region = "${var.aws_region}"
              }

              resource "random_id" "bucket_suffix" {
                byte_length = 4
              }

              # Example resource created directly by the EC2 instance
              resource "aws_s3_bucket" "test_bucket" {
                bucket        = "nested-tf-bucket-$${random_id.bucket_suffix.hex}"
                force_destroy = true

                tags = {
                  CreatedBy   = "EC2-Terraform-Runner"
                  Environment = "Nested-Lab"
                }
              }

              output "created_bucket_name" {
                value = aws_s3_bucket.test_bucket.bucket
              }
              INNER_TF

              # Ensure ubuntu user owns the workspace
              chown -R ubuntu:ubuntu /home/ubuntu/secondary-infra
              EOF

  tags = {
    Name = "terraform-controller-instance"
  }
}
