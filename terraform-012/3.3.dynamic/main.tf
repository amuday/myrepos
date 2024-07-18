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
    # iterator is optional. if not provided, access values using the block name, in this case it is ingress and ingress.value
    # The iterator argument (optional) sets the name of a temporary variable that represents the current element of the complex value. 
    # If omitted, the name of the variable defaults to the label of the dynamic block ("ingress" in the example above).
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
