# Instância Compute
resource "oci_core_instance" "main" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.main.id
  display_name        = "vm-${var.client_name}-${var.environment}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    display_name     = "vnic-${var.client_name}-${var.environment}"
    assign_public_ip = true
    hostname_label   = "vm${var.environment}"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.oracle_linux.images[0].id
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.ssh_key.public_key_openssh
    user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
      client_name = var.client_name
    }))
  }

  freeform_tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}
