# VPC e Infraestrutura de Rede
resource "google_compute_network" "main" {
  name                    = "vpc-${var.client_name}-${var.environment}"
  auto_create_subnetworks = false
  description             = "VPC criada via Terraform"
}

# Subnet
resource "google_compute_subnetwork" "main" {
  name          = "subnet-${var.client_name}-${var.environment}"
  ip_cidr_range = var.subnet_cidr
  region        = var.gcp_region
  network       = google_compute_network.main.id
  description   = "Subnet criada via Terraform"
}

# Firewall Rules
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-${var.client_name}-${var.environment}"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
  target_tags   = ["ssh-allowed"]

  description = "Permite SSH do IP atual"
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-${var.client_name}-${var.environment}"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]

  description = "Permite tráfego HTTP"
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https-${var.client_name}-${var.environment}"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]

  description = "Permite tráfego HTTPS"
}
