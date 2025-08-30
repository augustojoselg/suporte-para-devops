# Variáveis configuráveis
variable "gcp_project_id" {
  description = "ID do projeto GCP"
  type        = string
  default     = "SEU_PROJECT_ID_AQUI"
}

variable "gcp_region" {
  description = "Região GCP para deploy"
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "Zona GCP para deploy"
  type        = string
  default     = "us-central1-a"
}

variable "environment" {
  description = "Ambiente de deploy"
  type        = string
  default     = "prod"
}

variable "machine_type" {
  description = "Tipo de máquina"
  type        = string
  default     = "e2-micro"
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR da subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "client_name" {
  description = "Nome do cliente"
  type        = string
  default     = "seu-cliente-aqui"
}
