resource "aws_launch_template" "this" {
  name_prefix   = "test-template"
  image_id      = var.AMIS[var.region]
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.generated_key.key_name
  user_data              = filebase64("${path.module}/app1.sh")
}

resource "aws_autoscaling_group" "this" {
  name = "test-auto-scaling-group"

  vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  force_delete        = true

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

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  lb_target_group_arn    = aws_lb_target_group.frontend.arn
}