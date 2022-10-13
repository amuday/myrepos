resource "aws_instance" "dbserver" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  tags = {
    "Name" = "DB Server"
  }
}

output "dbserverPrivateIP" {
  value = aws_instance.dbserver.private_ip

}