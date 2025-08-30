# Variáveis configuráveis
variable "oci_tenancy_ocid" {
  description = "OCID do Tenancy OCI"
  type        = string
  default     = "SEU_TENANCY_OCID_AQUI"
}

variable "oci_user_ocid" {
  description = "OCID do usuário OCI"
  type        = string
  default     = "SEU_USER_OCID_AQUI"
}

variable "oci_fingerprint" {
  description = "Fingerprint da chave API"
  type        = string
  default     = "SEU_FINGERPRINT_AQUI"
}

variable "oci_private_key_path" {
  description = "Caminho para a chave privada da API"
  type        = string
  default     = "~/.oci/oci_api_key.pem"
}

variable "oci_region" {
  description = "Região OCI para deploy"
  type        = string
  default     = "us-ashburn-1"
}

variable "availability_domain" {
  description = "Availability Domain"
  type        = string
  default     = "1"
}

variable "environment" {
  description = "Ambiente de deploy"
  type        = string
  default     = "prod"
}

variable "instance_shape" {
  description = "Shape da instância"
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "vcn_cidr" {
  description = "CIDR da VCN"
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
