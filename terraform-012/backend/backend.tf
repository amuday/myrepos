terraform {
  backend "s3" {
    bucket = "terraform-bk-9-30-22"
    key    = "terraform/tfstate"
    region = "us-east-1"
  }
}