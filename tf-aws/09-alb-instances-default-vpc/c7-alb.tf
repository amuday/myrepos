resource "aws_lb" "this" {
  name               = "demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [data.aws_subnets.default.ids[0], data.aws_subnets.default.ids[1]]

  access_logs {
    bucket  = aws_s3_bucket.alb_access_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = local.common_tags
}

resource "aws_lb_target_group" "frontend" {
  name     = "test-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_target_group_attachment" "frontend_attachment" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = aws_instance.test_ec2_instance[count.index].id
  port             = 80
}

