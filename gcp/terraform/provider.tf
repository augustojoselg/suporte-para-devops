terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.0.0"
    }
  }
}

provider "google" {
  project     = "suporte-para-devops"
  region      = "us-west1"
}