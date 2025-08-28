# state.tf
terraform {
  backend "s3" {
    bucket  = "terraform-state-augustojoselg"
    key     = "aws/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}
