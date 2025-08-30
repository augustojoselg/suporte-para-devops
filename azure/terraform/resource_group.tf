# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.client_name}-${var.environment}"
  location = var.azure_region

  tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}
