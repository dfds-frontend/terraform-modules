variable "create_certificate" {
  description = "Whether to create ACM certificate"
  type        = bool
  default     = true
}

variable "domain_name" {}


variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "dns_zone_id" {
  description = "The ID of the hosted zone to contain this record."
  type        = string
  default     = null
}

variable "validation_method" {
  type        = string
  description = "Allowed values DNS and EMAIL"
}

variable "wait_for_validation" {
  default = true
}

variable "validation_allow_overwrite_records" {
  description = "Whether to allow overwrite of Route53 records"
  type        = bool
  default     = true
}

variable "validate_certificate" {
  description = "Whether to validate certificate by creating Route53 record"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {
    "Managed by" : "Terraform"
  }
}
