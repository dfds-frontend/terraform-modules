
bucket="mysatebucket" # choose an existing s3bucket
state_region="eu-central-1"
rm -rf .terraform
terraform init -backend-config "region=$state_region" -backend-config "key=mystate/terraform.tfstate" -backend-config "bucket=$bucket" 