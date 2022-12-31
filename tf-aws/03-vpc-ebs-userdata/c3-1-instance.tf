data "cloudinit_config" "cloudinit-example" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content = templatefile("scripts/init.cfg", {
      REGION = var.region
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("scripts/volumes.sh", {
      DEVICE = var.INSTANCE_DEVICE_NAME
    })
  }
}

resource "aws_instance" "test_instance" {
  subnet_id     = aws_subnet.public_a.id
  ami           = var.AMIS[var.region]
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  key_name               = aws_key_pair.generated_key.key_name

  user_data = data.cloudinit_config.cloudinit-example.rendered

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-a" }
  )
}
