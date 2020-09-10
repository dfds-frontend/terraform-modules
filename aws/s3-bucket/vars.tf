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

variable "retention_settings" {
  type = list(object({
      files_prefix = string
      retention_days = number
    }))

  default = []  
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {
    "Managed by" : "Terraform"
    }
}