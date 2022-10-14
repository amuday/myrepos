provider "aws" {
  region = "us-east-1"

}

variable "ingressrules" {
  type    = list(number)
  default = [80, 443]
}

variable "egressrules" {
  type    = list(number)
  default = [80, 443, 25, 8080]
}

resource "aws_instance" "ec2" {
  ami             = "ami-026b57f3c383c2eec"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  dynamic "ingress" {
    # if you dont use iterator, loop variable can be accessed by using block name, in this case ingress.
    iterator = port
    for_each = var.ingressrules
    content {
      cidr_blocks = ["0.0.0.0/0"]
      description = "inbound traffic"
      protocol    = "tcp"
      from_port   = port.value
      to_port     = port.value

    }

  }

  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      cidr_blocks = ["0.0.0.0/0"]
      description = "outbound traffic"
      protocol    = "tcp"
      from_port   = port.value
      to_port     = port.value

    }

  }
}
