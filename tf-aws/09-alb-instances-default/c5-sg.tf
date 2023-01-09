resource "aws_security_group" "instance" {
  vpc_id      = data.aws_vpc.default.id
  name        = "instance-sg"
  description = "Allow SSH, HTTP inbound traffic from alb"

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    "name" = "instnace" },
    local.common_tags
  )

}

resource "aws_security_group" "alb" {
  vpc_id      = data.aws_vpc.default.id
  name        = "alb-sg"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    "name" = "alb" },
    local.common_tags
  )
}