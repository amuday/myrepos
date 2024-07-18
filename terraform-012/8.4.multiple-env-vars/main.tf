provider "aws" {
  region = "us-east-1"

}

variable "number_of_servers" {
  type=number
  
}

resource "aws_instance" "ec2" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  count = var.number_of_servers
}