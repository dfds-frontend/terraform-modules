variable "name" {
  
}

variable force_detach_policies {
  default = true
}
variable "trusted_role_arn" {
  
}

variable "bucket_arn" {
  
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {
    "Managed by" : "Terraform"
    }  
}