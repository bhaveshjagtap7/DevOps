# Nested Infrastructure Template (Executed inside EC2 Controller)
# Provisioned using IAM Role Instance Profile credentials
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = var.target_region
}

variable "target_region" {
  type    = string
  default = "us-east-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "secondary_bucket" {
  bucket        = "terraform-controller-s3-${random_id.bucket_suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "Nested-Controller-Storage"
    Environment = "Controller-Managed"
    DeployedBy  = "EC2-Terraform-Runner"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.secondary_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

output "bucket_id" {
  value       = aws_s3_bucket.secondary_bucket.id
  description = "The ID of the nested S3 bucket created by the EC2 controller"
}