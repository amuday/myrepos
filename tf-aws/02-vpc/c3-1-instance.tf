resource "aws_instance" "test_instance" {
  subnet_id     = aws_subnet.public_a.id
  ami           = var.AMIS[var.region]
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  key_name               = aws_key_pair.generated_key.key_name

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-a" }
  )
}

data "aws_instance" "name" {
  
}