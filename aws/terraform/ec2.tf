resource "aws_instance" "srv_app_prod_01" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  subnet_id              = aws_subnet.public.id

  tags = {
    Name        = "app-server"
    Provisioned = "Terraform"
    Cliente     = "SEU_CLIENTE_AQUI"
  }
}

## Security Group

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Security Group para uso da APP"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name        = "app_sg"
    Provisioned = "Terraform"
    Cliente     = "SEU_CLIENTE_AQUI"
  }
}


## Ingress Rules

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.app_sg.id

  cidr_ipv4   = "${chomp(data.http.myip.response_body)}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.app_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.app_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

## Egress Rules

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.app_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1

}
