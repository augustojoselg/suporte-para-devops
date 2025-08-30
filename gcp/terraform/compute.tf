# IP Externo Estático
resource "google_compute_address" "main" {
  name         = "ip-${var.client_name}-${var.environment}"
  region       = var.gcp_region
  description  = "IP externo estático"
  address_type = "EXTERNAL"
}

# Instância Compute Engine
resource "google_compute_instance" "main" {
  name         = "vm-${var.client_name}-${var.environment}"
  machine_type = var.machine_type
  zone         = var.gcp_zone

  tags = ["ssh-allowed", "http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 20
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = google_compute_network.main.id
    subnetwork = google_compute_subnetwork.main.id

    access_config {
      nat_ip = google_compute_address.main.address
    }
  }

  metadata = {
    ssh-keys = "${var.client_name}:${tls_private_key.ssh_key.public_key_openssh}"
  }

  service_account {
    email  = google_service_account.main.email
    scopes = ["cloud-platform"]
  }

  labels = {
    environment = var.environment
    provisioned = "terraform"
    cliente     = var.client_name
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ${var.client_name}
    
    # Instalar Google Cloud SDK
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    apt-get update
    apt-get install -y google-cloud-sdk
  EOF
}
