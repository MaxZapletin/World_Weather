terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "max"
  region  = "eu-central-1"  
}

resource "aws_s3_bucket" "example" {
  bucket = "max-private-bucket-test2" 
}