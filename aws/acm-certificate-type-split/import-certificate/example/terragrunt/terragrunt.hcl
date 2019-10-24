// Configure Terragrunt to automatically store tfstate files in an S3 bucket. To get short intro to the used terragrunt specific functions, see bottom.
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket = get_env("terraform_state_s3bucket", "terraform-state-${get_aws_account_id()}-example-s3bucket")
    key            = "${path_relative_to_include()}/terraform.tfstate" 
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
     source = "./../../"
}


module "certificate_using_module" {
  //source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  source = "./../../"
  private_key = "${module.selfsigned_certificate.certificate_private_key_pem}" //var.private_key
  certificate_body = "${module.selfsigned_certificate.certificate_body_pem}" //var.certificate_body
}

module "selfsigned_certificate" {
    source = "./../self_signed_example_cert/"  
}

/*
Description of used terragrunt specific functions:
'path_relative_to_include()' adds the relative path from the root terragrunt.hcl file and any child module being added, simplifying state structure in the bucket (resembling the module folder structure).
'get_env("environment variable name", "default value if not found"). In this file used to set the s3 bucket name to store the terraform state in.'
*/