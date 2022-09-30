

variable "ingressrules" {
  type    = list(number)
  default = [80, 443]
}

variable "egressrules" {
  type    = list(number)
  default = [80, 443]
}

resource "aws_security_group" "websg" {
  name = "Allow http and https"

  dynamic "ingress" {
    # iterator is optional. if not provided access use the block name, in this case it is ingress and ingress.value
    # The iterator argument (optional) sets the name of a temporary variable that represents the current element of the complex value. 
    # If omitted, the name of the variable defaults to the label of the dynamic block ("setting" in the example above).
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
    for_each = var.egressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
}

output "sg_name" {
  value = aws_security_group.websg.name
}
