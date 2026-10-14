variable "aws_region" {
  type        = string
  description = "AWS deployment region"
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.aws_region))
    error_message = "The aws_region must follow standard AWS region format (e.g., us-east-1, eu-west-1)."
  }
}

variable "instance_type" {
  type        = string
  description = "EC2 instance sizing"
  default     = "t3.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Instance type must be a valid general-purpose test sizing (t2.micro, t3.micro, t3.small, t3.medium)."
  }
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Allowed CIDR block for SSH ingress. In production, restrict to your workstation IP."
  default     = "0.0.0.0/0"
}

variable "environment" {
  type        = string
  description = "Target deployment environment tag"
  default     = "development"
}