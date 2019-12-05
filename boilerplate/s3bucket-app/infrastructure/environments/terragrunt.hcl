# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = get_env("terraform_state_s3bucket", "terraform-state-${get_aws_account_id()}-tfstate-some_identifier") # some_identifier could be name of component or application: Example portal or portal-app (Note:underscore not allowed)
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
  }
}