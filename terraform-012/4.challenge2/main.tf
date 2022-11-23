provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "dbserver" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  tags = {
    "Name" = "DB Server"
  }
}


resource "aws_instance" "webserver" {
  ami             = "ami-026b57f3c383c2eec"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.websg.name]
  tags = {
    "Name" = "Web Server"
  }

  user_data = file("server-script.sh")
}

resource "aws_eip" "webeip" {
  instance = aws_instance.webserver.id
}

variable "ingressrules" {
  type    = list(number)
  default = [80, 443]
}

resource "aws_security_group" "websg" {
  name = "Allow http and https"

  dynamic "ingress" {
    # iterator is optional. if not provided access use the block name, in this case it is ingress and ingress.value
    # The iterator argument (optional) sets the name of a temporary variable that represents the current element of the complex value. 
    # If omitted, the name of the variable defaults to the label of the dynamic block ("ingress" in the example above).
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }


  dynamic "egress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

}



output "dbserverPrivateIP" {
  value = aws_instance.dbserver.private_ip

}

output "webserverPublicIP" {
  value = aws_eip.webeip.public_ip

}
