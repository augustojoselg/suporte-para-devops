# IAM Role para EC2
resource "aws_iam_role" "ec2_ecr_role" {
  name = "ECR_EC2_APP"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "ECR_EC2_APP"
    Provisioned = "Terraform"
    Cliente     = "SEU_CLIENTE_AQUI"
  }
}

# Política inline para acessar ECR
resource "aws_iam_role_policy" "ecr_inline_policy" {
  name = "ECR_Access_Policy"
  role = aws_iam_role.ec2_ecr_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      }
    ]
  })
}

# Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ECR_EC2_APP"
  role = aws_iam_role.ec2_ecr_role.name
}
