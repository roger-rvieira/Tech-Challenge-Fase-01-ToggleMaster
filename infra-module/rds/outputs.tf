output "endpoint" {
  description = "Endpoint de conexão ao banco."
  value       = aws_db_instance.this.endpoint
}

output "address" {
  description = "Hostname da instância RDS."
  value       = aws_db_instance.this.address
}

output "port" {
  description = "Porta da instância RDS."
  value       = aws_db_instance.this.port
}

output "security_group_id" {
  description = "ID do security group do RDS."
  value       = aws_security_group.this.id
}

output "secret_arn" {
  description = "ARN do segredo no AWS Secrets Manager com as credenciais do banco."
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "secret_name" {
  description = "Nome do segredo no AWS Secrets Manager com as credenciais do banco."
  value       = aws_secretsmanager_secret.db_credentials.name
}