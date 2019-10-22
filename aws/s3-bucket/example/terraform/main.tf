terraform {
  required_version = "~> 0.12.2"
  backend "s3" {}
}

// Region an dother vars are using the default values defined by the module: using DFDS default value defined in module ()"eu-central-1")

module "create_s3bucket_using_module" {
  //source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  source = "./../../"
  s3_bucket = var.s3_bucket_name
  enable_versioning = var.enable_versioning
  enable_destroy = var.enable_destroy
  enable_retention_policy = var.enable_retention_policy
  bucket_canned_acl = var.bucket_canned_acl
}