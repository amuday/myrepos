data "template_file" "script" {
  template = file("${path.module}/templates/script.sh")
  vars = {
    "app" = var.app_name
  }
}

resource "aws_instance" "test_ec2_instance" {
  count                  = var.instance_count
  subnet_id              = data.aws_subnets.default.ids[0]
  ami                    = lookup(var.AMIS, var.region, "us-east-1")
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data              = file("${path.module}/scripts/app1.sh")
  #user_data              = data.template_file.script.rendered
  tags = merge(
    { Name = "server-${count.index}" },
    local.common_tags
  )
}
