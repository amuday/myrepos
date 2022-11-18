provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "ec2" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
}

# implicit dependency - uses reference expressions.
# first ec2 will be created then eip
# in destroy - eip destroyed first then ec2
resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2.id
}


output "eip" {

  value = aws_eip.elasticip.public_ip

}