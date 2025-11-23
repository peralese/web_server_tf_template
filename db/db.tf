variable "dbserver" {
  type = string
}
resource "aws_instance" "dbserver" {
  ami           = "ami-0049e4b5ba14b6d36"
  instance_type = "t2.micro"

tags = {
    Name = var.dbserver
  }
}

output "DB_PrivateIP" {
  value = aws_instance.dbserver.private_ip
}
