resource "aws_launch_template" "this" {
  name_prefix   = "test-template"
  image_id      = var.AMIS[var.region]
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  key_name               = aws_key_pair.generated_key.key_name
}

resource "aws_autoscaling_group" "this" {
  name = "test-auto-scaling-group"

  vpc_zone_identifier  = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  health_check_type  = "EC2"
  force_delete       = true

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }

}