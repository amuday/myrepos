resource "aws_security_group" "web" {
  name = "sg-1"

  ingress  {
    cidr_blocks = ["0.0.0.0/0"]
    description = "inbound traffic"
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "outbound traffic"
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
  }
}