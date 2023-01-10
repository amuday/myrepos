data "template_file" "script" {
  template = file("${path.module}/templates/script.sh")
  vars = {
    "app"            = var.app_name
    "s3_bucket_name" = var.s3_bucket_name
  }
}

resource "aws_instance" "test_ec2_instance" {
  subnet_id              = data.aws_subnets.default.ids[0]
  ami                    = lookup(var.AMIS, var.region, "us-east-1")
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  user_data              = data.template_file.script.rendered
  iam_instance_profile   = aws_iam_instance_profile.s3_bucket_role_instance_profile.name
  tags = merge(
    { Name = "server-1" },
    local.common_tags
  )
}
