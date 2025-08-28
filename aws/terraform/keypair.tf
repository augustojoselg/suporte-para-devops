# Key Pair para SSH
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws-mentorias-01"
  public_key = tls_private_key.ssh_key.public_key_openssh

  tags = {
    Name        = "aws-mentorias-01"
    Provisioned = "Terraform"
    Cliente     = "Sysmac-NF"
  }
}

# Output para a chave privada (salvar localmente)
output "private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
}
