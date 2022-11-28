provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "challenge1vpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "TerraformVPC"
  }
}