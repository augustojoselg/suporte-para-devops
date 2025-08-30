# Compartment para organizar recursos
resource "oci_identity_compartment" "main" {
  compartment_id = var.oci_tenancy_ocid
  description    = "Compartment criado via Terraform para ${var.client_name}"
  name           = "${var.client_name}-${var.environment}"
  enable_delete  = true

  freeform_tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}
