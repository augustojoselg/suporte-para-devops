# Azure Container Registry
resource "azurerm_container_registry" "main" {
  name                = "acr${lower(replace(var.client_name, "_", ""))}${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}
