resource "aws_instance" "webserver" {
  ami             = "ami-026b57f3c383c2eec"
  instance_type   = "t2.micro"
  security_groups = [module.sg.sg_name]
  tags = {
    "Name" = "Web Server"
  }

  user_data = file("./web/server-script.sh")
}

module "eip" {
  source      = "../eip"
  instance_id = aws_instance.webserver.id
}

module "sg" {
  source = "../sg"

}

output "pub_ip" {
  value = module.eip.webserverPublicIP
}
