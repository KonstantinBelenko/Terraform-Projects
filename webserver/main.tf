# Get the latest aws ami for ubuntu
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ec2-webserver-1" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1a"
  key_name          = var.ec2_access_key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic-webserver-1.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo "${var.server_text}" > /var/www/html/index.html'
                EOF
  tags = {
    "Name" = "webserver-1"
  }
}
