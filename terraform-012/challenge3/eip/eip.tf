variable "instance_id" {
  type = string
}

resource "aws_eip" "webeip" {
  instance = var.instance_id
}


output "webserverPublicIP" {
  value = aws_eip.webeip.public_ip

}
