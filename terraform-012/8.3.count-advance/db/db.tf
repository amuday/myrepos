variable "server_names" {
  type=list(string)
  
}

resource "aws_instance" "dbserver" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  count = length(var.server_names)

  tags = {
    Name = var.server_names[count.index]
  }
}

output "PrivateIPs" {
  value = [aws_instance.dbserver.*.private_ip]

}