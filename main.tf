provider "aws" {
  region = "us-east-2"
}

variable "ssh_key_name" {
  description = "Existing AWS EC2 key pair name to associate for SSH access"
  type        = string
  default     = null
}

variable "ssh_ingress_cidrs" {
  description = "CIDR blocks that may reach the instance via SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

module "webmodule" {
  source            = "./web"
  webserver         = "WebServer"
  ssh_key_name      = var.ssh_key_name
  ssh_ingress_cidrs = var.ssh_ingress_cidrs
}

output "Web_PublicIP" {
  value = module.webmodule.Web_PublicIP
}
