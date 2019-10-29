variable "s3_bucket_name" {
  description = "The name of the S3 Bucket."
  default = "dfds-developer-example-terraform-s3bucket" // remember that s3 bucket names MUST be global unique across all AWS, accounts and regions! Due to this the example name here might fail, because it is already in use!
}

variable "enable_versioning" {
  default = false
}

variable "enable_destroy" {
  default = false
}

variable "enable_retention_policy" {
  default = false
  description = "Enable/Disable retention policy for content in S3 bucket. Useful when using S3 bucket to store logs."
}

variable "bucket_canned_acl" {
  default = "private"
  description = "Use one of the predefined grants. For more information: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl"
}