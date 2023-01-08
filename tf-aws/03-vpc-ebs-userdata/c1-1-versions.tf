terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.48"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}