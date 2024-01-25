terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.33.0"
    }
  }
  backend "s3" {
    bucket = "misyuro-test-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
