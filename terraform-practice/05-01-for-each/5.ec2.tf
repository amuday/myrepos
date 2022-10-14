
# AZ data source
data "aws_availability_zones" "my_azs" {

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_instance" "my_instance" {
  ami           = data.aws_ami.amz_linux.id
  instance_type = var.instance_type
  user_data     = file("${path.module}/install.sh")
  key_name      = var.instance_keypair
  vpc_security_group_ids = [
    aws_security_group.vpc_ssh.id,
    aws_security_group.vpc_web.id
  ]

  # create instance in each Az
  for_each = toset(data.aws_availability_zones.my_azs.names)
  # as for_each contains set int this case both each.key and each.value has same values.
  availability_zone = each.key
  tags = {
    "Name" = "Count EC2 Demo ${each.key}"
  }
}