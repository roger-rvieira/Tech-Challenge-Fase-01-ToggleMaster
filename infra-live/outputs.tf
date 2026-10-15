output "vpc_id" {
  description = "ID da VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs das sub-redes públicas."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs das sub-redes privadas."
  value       = module.vpc.private_subnet_ids
}

output "ec2_security_group_id" {
  description = "ID do security group da EC2."
  value       = module.ec2_security_group.security_group_id
}

output "rds_endpoint" {
  description = "Endpoint da instância RDS."
  value       = module.rds.endpoint
}

output "rds_security_group_id" {
  description = "ID do security group do RDS."
  value       = module.rds.security_group_id
}

output "rds_secret_name" {
  description = "Nome do segredo no AWS Secrets Manager com as credenciais do RDS."
  value       = module.rds.secret_name
}

output "rds_secret_arn" {
  description = "ARN do segredo no AWS Secrets Manager com as credenciais do RDS."
  value       = module.rds.secret_arn
}

output "ec2_iam_role_name" {
  description = "Nome da IAM Role anexada na EC2 para ler o AWS Secrets Manager."
  value       = module.ec2_instance.iam_role_name
}

output "ec2_instance_id" {
  description = "ID da instância EC2."
  value       = module.ec2_instance.instance_id
}

output "ec2_public_ip" {
  description = "IP público da instância EC2."
  value       = module.ec2_instance.public_ip
}

output "ec2_public_dns" {
  description = "DNS público da instância EC2."
  value       = module.ec2_instance.public_dns
}

output "ec2_key_name" {
  description = "Nome do key pair SSH criado na AWS."
  value       = module.ec2_instance.key_name
}

output "ssh_kms_key_id" {
  description = "ID da chave KMS usada para proteger a chave privada no SSM."
  value       = module.ec2_instance.kms_key_id
}

output "ssh_private_key_parameter_name" {
  description = "Nome do parametro SSM SecureString para armazenar e consultar a chave privada SSH."
  value       = module.ec2_instance.private_key_parameter_name
}