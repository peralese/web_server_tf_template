# Web Server Terraform Template

Deploys a single AWS EC2 instance configured as a web server. The instance uses a security group allowing HTTP/HTTPS (plus SSH from configurable CIDRs) and optional ports defined in `web/web.tf`, and bootstrap commands from `server-script.sh`.

What the bootstrap script does (`server-script.sh`):
- Updates packages (`yum -y update`) with fail-fast shell options.
- Installs osquery (via upstream repo), enables/starts `osqueryd`, and verifies it is active.
- Installs nginx, enables/starts it, checks health, and opens HTTP in firewalld when present.
- Writes a styled landing page to `/usr/share/nginx/html/index.html`.

## Prerequisites
- Terraform installed locally
- AWS credentials configured with permission to create EC2 instances and security groups
- Default region is `us-east-2` (change in `main.tf` if needed)
- (Recommended) An existing EC2 key pair you can pass through `ssh_key_name` to enable SSH

## Quickstart
```bash
terraform init
terraform plan
terraform apply -var 'ssh_key_name=your-keypair-name'
```

Edit `main.tf` to adjust the web server name or region as needed before applying.

## Outputs
- `Web_PublicIP`: public IP of the web server instance

## Project Structure
- `main.tf` - root module configuring AWS and calling the web module
- `web/web.tf` - EC2 instance, security group, outputs
- `server-script.sh` - user data script run on instance startup
- `.gitignore` - ignores `.terraform/` directory (consider also ignoring `terraform.tfstate*` if you keep state locally)
- Module variables `ssh_key_name` / `ssh_ingress_cidrs` (defaults to `["0.0.0.0/0"]`) control SSH access

## Cleanup
```bash
terraform destroy
```
