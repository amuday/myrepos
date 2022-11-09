variable "ingressrules" {
  type    = list(number)
  default = [80, 443, 22]
}

variable "egressrules" {
  type    = list(number)
  default = [80, 443, 22]
}

resource "aws_security_group" "web_ssh_traffic" {
  name = " web and ssh traffic"
  
  dynamic "ingress" {
    for_each = var.ingressrules
    iterator = port

    content {
      cidr_blocks = ["0.0.0.0/0"]
      description = "inbound traffic"
      protocol    = "tcp"
      from_port   = port.value
      to_port     = port.value

    }
  }

  dynamic "egress" {
    for_each = var.egressrules
    iterator = port

    content {
      cidr_blocks = ["0.0.0.0/0"]
      description = "outbound traffic"
      protocol    = "tcp"
      from_port   = port.value
      to_port     = port.value
    }
  }
}