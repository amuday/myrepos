provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "my_local_key" {
  key_name   = "my-local-key"
  public_key = file("C:/Users/udayk/.ssh/id_rsa.pub")
}

resource "aws_instance" "myserver" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"

  # using key which is created in local machine
  key_name = aws_key_pair.my_local_key.key_name

  # using key which is created in AWS
  #key_name        = "eks-terraform-key"

  #security_groups = data.aws_security_groups.sg.ids

  security_groups = [aws_security_group.web_ssh_traffic.name]

  tags = {
    "name" = "my-vm"
  }

  provisioner "local-exec" {
    command     = "echo VM created on %date% %time% public ip is ${aws_instance.myserver.public_ip} >> VM-IP.txt"
    working_dir = "output/"
  }

  provisioner "local-exec" {
    command     = "echo VM destroyed on %date% %time% >> VM-IP-destroy.txt"
    working_dir = "output/"
    when        = destroy
  }

}

/*
data "aws_security_groups" "sg" {
  filter {
    name   = "group-name"
    values = ["ssh-http-all-allow"]
  }

}

output "sg" {
  value = data.aws_security_groups.sg.ids

}

*/

