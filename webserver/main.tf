provider "aws" {
  region     = "eu-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

### VARIABLES ###
variable "prod-subnet-prefix" {
  description = "Cidr block for prod subnet"
  default     = ["10.0.1.0/24"]
  type        = list
}
variable "access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}
variable "secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}
#################

# Production VPC
resource "aws_vpc" "vpc-prod-1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}

# Production gateway & route table
resource "aws_internet_gateway" "gateway-prod-1" {
  vpc_id = aws_vpc.vpc-prod-1.id
}

resource "aws_route_table" "route-table-prod-1" {
  vpc_id = aws_vpc.vpc-prod-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway-prod-1.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gateway-prod-1.id
  }

  tags = {
    "Name" = "route-table-prod-1"
  }
}

# Prod subnet
resource "aws_subnet" "subnet-prod-1" {
  vpc_id            = aws_vpc.vpc-prod-1.id
  cidr_block        = var.prod-subnet-prefix[0]
  availability_zone = "eu-central-1a"

  tags = {
    "Name" = "subnet-prod-1"
  }
}

# Route table association
resource "aws_route_table_association" "route-table-association-prod-1" {
  subnet_id      = aws_subnet.subnet-prod-1.id
  route_table_id = aws_route_table.route-table-prod-1.id
}

# Security group for prod instance
resource "aws_security_group" "security-group-allow-web" {
  name        = "Allow web traffic"
  description = "Allow web traffic + ssh  "
  vpc_id      = aws_vpc.vpc-prod-1.id

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

resource "aws_network_interface" "nic-prod-webserver-1" {
  subnet_id       = aws_subnet.subnet-prod-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.security-group-allow-web.id]
}

resource "aws_eip" "eip-prod-webserver-1" {
  vpc                       = true
  network_interface         = aws_network_interface.nic-prod-webserver-1.id
  associate_with_private_ip = "10.0.1.50"

  depends_on = [
    aws_internet_gateway.gateway-prod-1
  ]
}

resource "aws_instance" "ec2-prod-webserver-1" {
  ami               = "ami-065deacbcaac64cf2"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1a"
  key_name          = "terraform-access-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic-prod-webserver-1.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo "Hello World!" > /var/www/html/index.html'
                EOF
  tags = {
    "Name" = "prod-webserver-1"
  }
}

# Outputs

output "prod-webserver-1-public-ip" {
  value = aws_instance.ec2-prod-webserver-1.public_ip
}
