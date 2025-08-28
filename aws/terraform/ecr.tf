resource "aws_ecr_repository" "ecr_aws_prod" {
  name                 = "app_prod"
  image_tag_mutability = "MUTABLE"
}