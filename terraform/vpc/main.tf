resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.vpc_name}-private-${count.index}"
  }
}

resource "aws_security_group" "ecs" {
  vpc_id = aws_vpc.main.id
  name   = "ecs-security-group"

  ingress {
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

  tags = {
    Name = "ecs-sg"
  }
}

resource "aws_security_group" "ecr_vpc_endpoint" {
  vpc_id = aws_vpc.main.id
  name   = "ecr-vpc-endpoint-sg"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecr-vpc-endpoint-sg"
  }
}
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-central-1.ecr.api"  
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.public[*].id  
  security_group_ids = [aws_security_group.ecr_vpc_endpoint.id]

  tags = {
    Name = "${var.vpc_name}-ecr-api"
  }
}

resource "aws_vpc_endpoint" "ecr_docker" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-central-1.ecr.dkr"  
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.public[*].id  
  security_group_ids = [aws_security_group.ecr_vpc_endpoint.id]

  tags = {
    Name = "${var.vpc_name}-ecr-docker"
  }
}