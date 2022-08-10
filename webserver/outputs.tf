output "webserver-1-public-ip" {
  value = aws_instance.ec2-webserver-1.public_ip
}