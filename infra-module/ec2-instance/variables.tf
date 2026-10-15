variable "name" {
  description = "Prefixo usado no nome da instância."
  type        = string
}

variable "public_subnet_id" {
  description = "ID da sub-rede pública onde a instância será criada."
  type        = string
}

variable "security_group_id" {
  description = "ID do security group associado à instância."
  type        = string
}

variable "key_name" {
  description = "Nome do par de chaves SSH a criar na região AWS."
  type        = string
}

variable "public_key_path" {
  description = "Caminho local da chave SSH publica."
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2."
  type        = string
  default     = "t3.micro"
}

variable "aws_region" {
  description = "Região AWS onde o segredo está armazenado."
  type        = string
  default     = "us-east-1"
}

variable "db_secret_arn" {
  description = "ARN do segredo no AWS Secrets Manager contendo as credenciais do banco."
  type        = string
}

variable "db_secret_name" {
  description = "Nome do segredo no AWS Secrets Manager contendo as credenciais do banco."
  type        = string
}

variable "app_repo_url" {
  description = "URL do repositório da aplicação para clonar na EC2."
  type        = string
  default     = "https://github.com/dougls/toggle-master-monolith.git"
}