variable "name" {
  description = "The name of the CloudWatch log group."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {
    "Managed by" : "Terraform"
  }
}


variable "retention_days" {
  description = "The number of days to retain log events in the CloudWatch log group."
  type        = number
  default     = 90
}

variable "deploy" {
  description = "Whether to deploy the CloudWatch log group."
  type        = bool
  default     = true
}
