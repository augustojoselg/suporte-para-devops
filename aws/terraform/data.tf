# Data sources para recursos dinâmicos
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Data source para obter o IP público atual
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
