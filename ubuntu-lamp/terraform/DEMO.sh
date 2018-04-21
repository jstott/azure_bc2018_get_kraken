# ************************************************
# NOT INTENDED to be run as a script - but as placeholder 
# for lines to be executed as part of demo
# ************************************************
## Terraform standard way
terraform workspace select dev
terraform plan -var-file=./config/dev.tfvars -out=dev.plan
terraform apply dev.plan

terraform show  dev.plan

## Script / wrapper way (Makefile for example)
make plan dev
make apply dev
make destroy dev