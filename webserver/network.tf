# VPC
resource "aws_vpc" "vpc-1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Production VPC"
  }
}

# Gateway & route table
resource "aws_internet_gateway" "gateway-1" {
  vpc_id = aws_vpc.vpc-1.id
}

# Subnet 1
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    "Name" = "Subnet-1"
  }
}

# Route table
resource "aws_route_table" "route-table-1" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway-1.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gateway-1.id
  }

  tags = {
    "Name" = "route-table-1"
  }
}

# Route table association
resource "aws_route_table_association" "route-table-association-1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route-table-1.id
}

# Security group for instance
resource "aws_security_group" "security-group-allow-web" {
  name        = "Allow web traffic"
  description = "Allow web traffic + ssh  "
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    "Name" = "Allow web"
  }
}

# Network interface
resource "aws_network_interface" "nic-webserver-1" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.security-group-allow-web.id]
}

# Elastic ip
resource "aws_eip" "eip-webserver-1" {
  vpc                       = true
  network_interface         = aws_network_interface.nic-webserver-1.id
  associate_with_private_ip = "10.0.1.50"

  depends_on = [
    aws_internet_gateway.gateway-1
  ]
}