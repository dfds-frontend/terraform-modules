variable "name" {
  description = "The name of the IAM role."
  type        = string
}

variable "force_detach_policies" {
  description = "Whether to force detach policies from the role."
  type        = bool
  default     = true
}

variable "trusted_role_arn" {
  description = "The ARN of the role to trust."
  type        = string
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {
    "Managed by" : "Terraform"
  }
}
