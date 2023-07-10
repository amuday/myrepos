resource "aws_security_group" "codebuild-egress" {
  name_prefix = "${var.prefix}-kafka-codebuild-"
  description = "Group that CodeBuild uses to allow access to resources in the VPC and the Internet."
  vpc_id      = data.aws_vpc.this.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]   
  }
  tags = merge(var.tags, { Name : "${var.prefix}-kafka-codebuild" })
}

resource "aws_security_group" "instance-sg" {
  name_prefix = "${var.prefix}-kafka-codebuild-instance"
  description = "SG for packer ami build"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description = "Allow rdp within vpc"
    from_port        = 5986
    to_port          = 5986
    protocol         = "tcp"
    security_groups = [aws_security_group.codebuild-egress.id]   
  }

  ingress {
    description = "Allow ssh within vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [aws_security_group.codebuild-egress.id]   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]   
  }

}