# Key Pair para SSH
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  tags = {
    Name        = "deployer-key"
    Provisioned = "Terraform"
    Cliente     = "SEU_CLIENTE_AQUI"
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
