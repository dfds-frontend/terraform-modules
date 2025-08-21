variable "deploy" {
  type    = bool
  default = true
}

variable "s3_bucket" {
  type        = string
  description = "The name of the S3 Bucket."
}
variable "allowed_iam_arns" {
  type    = list(any)
  default = []
}

variable "enable_versioning" {
  type    = bool
  default = false
}

variable "enable_destroy" {
  type    = bool
  default = true
}

variable "bucket_canned_acl" {
  type        = string
  default     = "private"
  description = "Use one of the predefined grants. For more information: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl"
  validation {
    condition     = contains(["private", "public-read", "public-read-write", "authenticated-read"], var.bucket_canned_acl)
    error_message = "Canned ACL must be one of private, public-read, public-read-write, authenticated-read."
  }
}

variable "retention_settings" {
  type = list(object({
    files_prefix   = string
    retention_days = number
  }))

  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {
    "Managed by" : "Terraform"
  }
}
