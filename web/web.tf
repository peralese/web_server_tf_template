variable "webserver" {
  type = string
}

variable "ingressrules" {
  type = list(number)
  default = [80, 443]
}

variable "egressrules" {
  type = list(number)
  default = [80, 443]
}

variable "ssh_key_name" {
  description = "Existing AWS EC2 key pair name to associate for SSH access"
  type        = string
  default     = null
}

variable "ssh_ingress_cidrs" {
  description = "CIDR blocks that may initiate SSH connections"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

resource "aws_instance" "webserver" {
  ami           = "ami-0049e4b5ba14b6d36"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.sg.name]
  key_name        = var.ssh_key_name
  user_data       = file("./server-script.sh")

  tags = {
    Name = var.webserver
  }
}

resource "aws_security_group" "sg" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_ingress_cidrs
  }


  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "Web_PublicIP" {
  value = aws_instance.webserver.public_ip
}
