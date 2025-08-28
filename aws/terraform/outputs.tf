# Outputs importantes
output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.srv_app_prod_01.id
}

output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.srv_app_prod_01.public_ip
}

output "instance_public_dns" {
  description = "DNS público da instância EC2"
  value       = aws_instance.srv_app_prod_01.public_dns
}

output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID da subnet pública"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID do security group"
  value       = aws_security_group.app_sg.id
}

output "ecr_repository_url" {
  description = "URL do repositório ECR"
  value       = aws_ecr_repository.ecr_aws_prod.repository_url
}

output "ssh_connection" {
  description = "Comando para conectar via SSH"
  value       = "ssh -i ~/.ssh/aws-mentorias-01.pem ec2-user@${aws_instance.srv_app_prod_01.public_ip}"
}

output "iam_role_used" {
  description = "IAM Role usado na instância EC2"
  value       = aws_iam_role.ec2_ecr_role.name
}

output "iam_instance_profile" {
  description = "IAM Instance Profile criado"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "iam_role_arn" {
  description = "ARN do IAM Role criado"
  value       = aws_iam_role.ec2_ecr_role.arn
}
