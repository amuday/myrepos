
resource "aws_ebs_volume" "main" {
  #availability_zone = aws_instance.test_instance.availability_zone
  availability_zone = "${data.aws_region.current.name}a"
  size              = 20

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-a" }
  )

}

resource "aws_volume_attachment" "main" {
  device_name = var.INSTANCE_DEVICE_NAME
  volume_id   = aws_ebs_volume.main.id
  instance_id = aws_instance.test_instance.id
  skip_destroy= true                            # skip destroy to avoid issues with terraform destroy
}
