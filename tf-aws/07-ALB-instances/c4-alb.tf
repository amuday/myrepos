resource "aws_lb" "this" {
  name                             = "alb-test"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb.id]
  subnets                          = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "frontend" {
  name     = "test-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type              = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_target_group_attachment" "frontend_attachment" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = aws_instance.test_instance[count.index].id
  port             = 80
}

