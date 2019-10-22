//variables here are defined for the sole purpose of ensuring terraform.tfvars and parent modules using this module invocation can pass values into the variables defined by the module invocation in this file 
variable region {
  description = "Target AWS region (used in provider section, not in resource def.), default region of choice in DFDS is eu-central-1."
  type        = string
  default     = "eu-central-1"
}

variable "s3_bucket" {
  description = "The name of the S3 Bucket."
  default = "dfds-developer-example-terraform-s3bucket" // remember that s3 bucket names MUST be global unique across all AWS, accounts and regions! Due to this the example name here might fail, because it is already in use!
}
variable "allowed_iam_arns" {
  type = list
  default = []
}

variable "enable_versioning" {
  default = false
}

variable "enable_destroy" {
  default = false
}

variable "bucket_canned_acl" {
  default = "private"
  description = "Use one of the predefined grants. For more information: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl"
}

variable "enable_retention_policy" {
  default = false
  description = "Enable/Disable retention policy for content in S3 bucket. Useful when using S3 bucket to store logs."
}


variable "retention_days" {
  description = "The number of days to keep content in s3 bucket."
  default = 90
}

variable "lifecycle_rule_files_prefix" {
  default = ""
  description = "Specify which files, the retention settings will apply for, based on prefix/file path."
}

terraform {
  backend "s3" {
  }
}

module "aws_s3_bucket_resource_usemodule" {
  //source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  source = "./../"
  s3_bucket = var.s3_bucket
  enable_versioning = var.enable_versioning
  enable_destroy = var.enable_destroy
  enable_retention_policy = var.enable_retention_policy
  retention_days = var.retention_days
  bucket_canned_acl = var.bucket_canned_acl
}