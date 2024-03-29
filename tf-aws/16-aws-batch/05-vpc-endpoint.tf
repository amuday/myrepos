# commented as main.tf file aws_batch_job_definition.this -> networkConfiguration -> assignPublicIp is enabled

/*
resource "aws_vpc_endpoint" "ecr-dkr-endpoint" {
  vpc_id              = data.aws_vpc.default.id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpc_endpoint.id]
  subnet_ids          = data.aws_subnets.default.ids

}

resource "aws_vpc_endpoint" "ecr-api-endpoint" {
  vpc_id              = data.aws_vpc.default.id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_endpoint.id]
  subnet_ids          = data.aws_subnets.default.ids
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = data.aws_vpc.default.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [data.aws_route_table.main.id]
  #policy            = data.aws_iam_policy_document.s3_ecr_access.json

}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = data.aws_vpc.default.id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpc_endpoint.id]
  subnet_ids          = data.aws_subnets.default.ids

  tags = {
    Name        = "logs-endpoint"
    Environment = "dev"
  }
}

*/

resource "aws_security_group" "vpc_endpoint" {
  name = "SG for VPC endpoint"

  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "tcp"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

