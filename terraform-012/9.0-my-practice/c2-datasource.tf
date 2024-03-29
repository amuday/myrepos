data "aws_ami" "get_amis" {
  most_recent = true
  owners      = ["amazon"]


  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}

data "aws_vpc" "main" {
  default = true
}

data "aws_route_tables" "main" {
  vpc_id = data.aws_vpc.main.id
}