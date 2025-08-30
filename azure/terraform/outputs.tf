# Outputs importantes
output "resource_group_name" {
  description = "Nome do Resource Group"
  value       = azurerm_resource_group.main.name
}

output "vm_id" {
  description = "ID da VM"
  value       = azurerm_linux_virtual_machine.main.id
}

output "vm_public_ip" {
  description = "IP público da VM"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_private_ip" {
  description = "IP privado da VM"
  value       = azurerm_network_interface.main.private_ip_address
}

output "vnet_id" {
  description = "ID da VNet criada"
  value       = azurerm_virtual_network.main.id
}

output "subnet_id" {
  description = "ID da subnet pública"
  value       = azurerm_subnet.public.id
}

output "nsg_id" {
  description = "ID do Network Security Group"
  value       = azurerm_network_security_group.app_nsg.id
}

output "acr_login_server" {
  description = "URL do servidor de login do ACR"
  value       = azurerm_container_registry.main.login_server
}

output "acr_admin_username" {
  description = "Nome de usuário admin do ACR"
  value       = azurerm_container_registry.main.admin_username
}

output "acr_admin_password" {
  description = "Senha admin do ACR"
  value       = azurerm_container_registry.main.admin_password
  sensitive   = true
}

output "ssh_connection" {
  description = "Comando para conectar via SSH"
  value       = "ssh -i ~/.ssh/azure-key.pem ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}
