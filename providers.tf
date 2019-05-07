provider "aws" {
  region = "${var.region}"
  version = "2.7"
}

terraform {
  required_version = ">= 0.11.13"

  backend "s3" {
    bucket = "ar3-terraform-bucket-dev-us-east-1"
    key = "my/vpc"
    region = "us-east-1"
    
  }
}