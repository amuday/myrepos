resource "aws_instance" "my_instance" {
  ami = data.aws_ami.amz_linux.id
  #instance_type = var.instance_type
  count         = length(var.instance_type_list)
  instance_type = var.instance_type_list[count.index]
  user_data     = file("${path.module}/install.sh")
  key_name      = var.instance_keypair
  vpc_security_group_ids = [
    aws_security_group.vpc_ssh.id,
    aws_security_group.vpc_web.id
  ]


  tags = {
    "Name" = "Count EC2 Demo ${count.index}"
  }
}