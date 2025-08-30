# Outputs importantes
output "compartment_id" {
  description = "OCID do Compartment criado"
  value       = oci_identity_compartment.main.id
}

output "compartment_name" {
  description = "Nome do Compartment"
  value       = oci_identity_compartment.main.name
}

output "instance_id" {
  description = "OCID da instância"
  value       = oci_core_instance.main.id
}

output "instance_public_ip" {
  description = "IP público da instância"
  value       = oci_core_instance.main.public_ip
}

output "instance_private_ip" {
  description = "IP privado da instância"
  value       = oci_core_instance.main.private_ip
}

output "vcn_id" {
  description = "OCID da VCN criada"
  value       = oci_core_vcn.main.id
}

output "subnet_id" {
  description = "OCID da subnet pública"
  value       = oci_core_subnet.public.id
}

output "internet_gateway_id" {
  description = "OCID do Internet Gateway"
  value       = oci_core_internet_gateway.main.id
}

output "ocir_namespace" {
  description = "Namespace do OCIR"
  value       = data.oci_objectstorage_namespace.main.namespace
}

output "ocir_endpoint" {
  description = "Endpoint do OCIR"
  value       = "${substr(var.oci_region, 0, 3)}.ocir.io"
}

output "ocir_repository_url" {
  description = "URL base do repositório OCIR"
  value       = "${substr(var.oci_region, 0, 3)}.ocir.io/${data.oci_objectstorage_namespace.main.namespace}"
}

output "ssh_connection" {
  description = "Comando para conectar via SSH"
  value       = "ssh -i ~/.ssh/oci-key.pem opc@${oci_core_instance.main.public_ip}"
}

output "region_used" {
  description = "Região utilizada"
  value       = var.oci_region
}

output "availability_domain" {
  description = "Availability Domain utilizado"
  value       = data.oci_identity_availability_domains.ads.availability_domains[0].name
}
