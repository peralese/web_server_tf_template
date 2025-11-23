provider "aws" {
  region = "us-east-2"
}

module "webmodule" {
  source = "./web"  
  webserver = "WebServer"
}

module "dbmodule" {
  source = "./db"
  dbserver = "DBServer"
} 

output "Web_PublicIP" {
  value = module.webmodule.Web_PublicIP
}

output "DB_PrivateIP" {
  value = module.dbmodule.DB_PrivateIP
}