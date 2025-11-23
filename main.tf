provider "aws" {
  region = "us-east-2"
}

module "webmodule" {
  source    = "./web"
  webserver = "WebServer"
}

output "Web_PublicIP" {
  value = module.webmodule.Web_PublicIP
}
