variable "deploy" {
  default = true
}

variable "s3_bucket" {
  description = "The name of the S3 Bucket."
}
variable "allowed_iam_arns" {
  type = list
  default = []
}

variable "enable_versioning" {
  default = false
}

variable "enable_destroy" {
  default = true
}

variable "bucket_canned_acl" {
  default = "private"
  description = "Use one of the predefined grants. For more information: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl"
}

variable "lifecycle_rules" {
  type = list(object({
      files_prefix = string
      retention_days = number
    }))
}


# variable "enable_retention_policy" {
#   default = false
#   description = "Enable/Disable retention policy for content in S3 bucket. Useful when using S3 bucket to store logs."
# }

# variable "retention_days" {
#   description = "The number of days to keep content in s3 bucket."
#   default = 90
# }

# variable "lifecycle_rule_files_prefix" {
#   default = ""
#   description = "Specify which files, the retention settings will apply for, based on prefix/file path."
# }

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {
    "Managed by" : "Terraform"
    }
}