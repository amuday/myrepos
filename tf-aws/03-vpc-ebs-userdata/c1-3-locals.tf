locals {
  #prefix = "${var.prefix}-${terraform.workspace}"
  prefix = var.prefix
  common_tags = {
    #Environment = terraform.workspace
    Environment = "dev"
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }
}

data "aws_region" "current" {}