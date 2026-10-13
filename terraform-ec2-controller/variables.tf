variable "aws_region" {
  type        = string
  description = "AWS deployment region"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance sizing"
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Allowed CIDR block for SSH ingress. In production, restrict to your workstation IP."
  default     = "0.0.0.0/0"
}
