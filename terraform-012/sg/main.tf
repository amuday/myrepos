provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "ec2" {
  ami             = "ami-026b57f3c383c2eec"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  ingress  {
    cidr_blocks = ["0.0.0.0/0"]
    description = "inbound traffic"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "outbound traffic"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }
}