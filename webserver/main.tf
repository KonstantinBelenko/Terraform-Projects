resource "aws_instance" "ec2-webserver-1" {
  ami               = "ami-065deacbcaac64cf2"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1a"
  key_name          = "terraform-access-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic-webserver-1.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo "Hello World!" > /var/www/html/index.html'
                EOF
  tags = {
    "Name" = "webserver-1"
  }
}
