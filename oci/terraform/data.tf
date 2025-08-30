# Data source para obter Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.oci_tenancy_ocid
}

# Data source para obter a imagem mais recente do Oracle Linux
data "oci_core_images" "oracle_linux" {
  compartment_id           = var.oci_tenancy_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

# Data source para obter o IP público atual
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
