# Data source para obter a imagem mais recente do Ubuntu
data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

# Data source para obter o IP público atual
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
