# Data source para obter o IP público atual
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
