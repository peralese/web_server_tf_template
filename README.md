# Web Server Terraform Template

Deploys a single AWS EC2 instance configured as a web server. The instance uses a security group allowing HTTP/HTTPS and optional ports defined in `web/web.tf`, and bootstrap commands from `server-script.sh`.

## Prerequisites
- Terraform installed locally
- AWS credentials configured with permission to create EC2 instances and security groups
- Default region is `us-east-2` (change in `main.tf` if needed)

## Quickstart
```bash
terraform init
terraform plan
terraform apply
```

Edit `main.tf` to adjust the web server name or region as needed before applying.

## Outputs
- `Web_PublicIP`: public IP of the web server instance

## Project Structure
- `main.tf` - root module configuring AWS and calling the web module
- `web/web.tf` - EC2 instance, security group, outputs
- `server-script.sh` - user data script run on instance startup
- `.gitignore` - ignores `.terraform/` directory (consider also ignoring `terraform.tfstate*` if you keep state locally)

## Cleanup
```bash
terraform destroy
```
