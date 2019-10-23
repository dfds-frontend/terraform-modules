/*
terraform {
  required_version = "~> 0.12.2"
}// might just live in module def folder instead?
*/

module "certificate_using_module" {
  //source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  source = "./../../"
  private_key = var.private_key
  certificate_body = var.certificate_body
  certificate_chain = var.certificate_chain
}