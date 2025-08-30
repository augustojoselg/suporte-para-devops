# Virtual Cloud Network (VCN)
resource "oci_core_vcn" "main" {
  compartment_id = oci_identity_compartment.main.id
  cidr_block     = var.vcn_cidr
  display_name   = "vcn-${var.client_name}-${var.environment}"
  dns_label      = "vcnmain"

  freeform_tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}

# Internet Gateway
resource "oci_core_internet_gateway" "main" {
  compartment_id = oci_identity_compartment.main.id
  vcn_id         = oci_core_vcn.main.id
  display_name   = "igw-${var.client_name}-${var.environment}"

  freeform_tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}

# Route Table
resource "oci_core_route_table" "public" {
  compartment_id = oci_identity_compartment.main.id
  vcn_id         = oci_core_vcn.main.id
  display_name   = "rt-public-${var.client_name}-${var.environment}"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.main.id
  }

  freeform_tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}

# Security List
resource "oci_core_security_list" "public" {
  compartment_id = oci_identity_compartment.main.id
  vcn_id         = oci_core_vcn.main.id
  display_name   = "sl-public-${var.client_name}-${var.environment}"

  # Regras de entrada
  ingress_security_rules {
    protocol = "6" # TCP
    source   = "${chomp(data.http.myip.response_body)}/32"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      max = 80
      min = 80
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      max = 443
      min = 443
    }
  }

  # Regras de saída
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  freeform_tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}

# Subnet Pública
resource "oci_core_subnet" "public" {
  compartment_id    = oci_identity_compartment.main.id
  vcn_id            = oci_core_vcn.main.id
  cidr_block        = var.subnet_cidr
  display_name      = "subnet-public-${var.client_name}-${var.environment}"
  dns_label         = "subnetpublic"
  route_table_id    = oci_core_route_table.public.id
  security_list_ids = [oci_core_security_list.public.id]

  freeform_tags = {
    Environment = var.environment
    Provisioned = "Terraform"
    Cliente     = var.client_name
  }
}
