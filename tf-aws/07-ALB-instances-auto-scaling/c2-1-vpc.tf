resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-vpc" }
  )
}

######## subnets ############
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}a"

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-a" }
  )
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}b"

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-b" }
  )
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "${data.aws_region.current.name}a"

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-private-a" }
  )
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "${data.aws_region.current.name}b"

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-private-b" }
  )
}


## IGW 

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-main" }
  )
}

resource "aws_route_table" "public_main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-a" }
  )
}

# does not support tags
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_main.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_main.id
}

### NAT ####
/*
resource "aws_eip" "main" {
  vpc = true

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-a" }
  )
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public_a.id

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-public-a" }
  )
}

resource "aws_route_table" "private_main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(
    local.common_tags,
    { "Name" = "${local.prefix}-private-a" }
  )
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_main.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_main.id
}

*/