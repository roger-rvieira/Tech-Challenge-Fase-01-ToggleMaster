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

variable "db_host" {
  description = "Hostname da instância RDS (sem a porta)."
  type        = string
  default     = ""
}

variable "db_name" {
  description = "Nome inicial do banco de dados."
  type        = string
  default     = "appdb"
}

variable "db_user" {
  description = "Usuário do banco de dados."
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "Senha do usuário administrador do banco de dados."
  type        = string
  default     = ""
  sensitive   = true
}

variable "app_repo_url" {
  description = "URL do repositório da aplicação para clonar na EC2."
  type        = string
  default     = "https://github.com/dougls/toggle-master-monolith.git"
}