variable "deploy" {
  default = true
}

variable waf_prefix {
  description = "Prefix to use when naming resources"

  default = "samdi"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {
    "Managed by" : "Terraform"
    }
}

variable rule_sqli_action {
  default     = "COUNT"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}