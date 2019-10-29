// Configure Terragrunt to automatically store tfstate files in an S3 bucket. To get short intro to the used terragrunt specific functions, see bottom.
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket = get_env("terraform_state_s3bucket", "terraform-state-${get_aws_account_id()}-example-s3bucket")
    key            = "${path_relative_to_include()}/import-certificate-example/terraform.tfstate" 
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}