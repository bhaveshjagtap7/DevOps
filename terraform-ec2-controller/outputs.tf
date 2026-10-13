output "controller_public_ip" {
  description = "Public IP address of the Terraform controller EC2 instance"
  value       = aws_instance.terraform_runner.public_ip
}

output "ssh_command" {
  description = "Ready-to-use SSH connection command"
  value       = "ssh -i ${local_file.private_key_pem.filename} ubuntu@${aws_instance.terraform_runner.public_ip}"
}

output "controller_instance_id" {
  description = "Instance ID of the Terraform controller EC2 instance"
  value       = aws_instance.terraform_runner.id
}

output "security_group_id" {
  description = "ID of the controller security group"
  value       = aws_security_group.runner_sg.id
}
