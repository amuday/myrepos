resource "aws_instance" "test_instance" {
  count         = var.instance_count
  subnet_id     = aws_subnet.public_a.id
  ami           = var.AMIS[var.region]
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.generated_key.key_name
  user_data              = file("${path.module}/app1.sh")
  
  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-a" }
  )
}

