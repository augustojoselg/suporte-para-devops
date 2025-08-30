# Variáveis configuráveis
variable "azure_region" {
  description = "Região Azure para deploy"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Ambiente de deploy"
  type        = string
  default     = "prod"
}

variable "vm_size" {
  description = "Tamanho da VM"
  type        = string
  default     = "Standard_B1s"
}

variable "vnet_cidr" {
  description = "CIDR da VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR da subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "client_name" {
  description = "Nome do cliente"
  type        = string
  default     = "SEU_CLIENTE_AQUI"
}

variable "admin_username" {
  description = "Nome do usuário administrador da VM"
  type        = string
  default     = "azureuser"
}
