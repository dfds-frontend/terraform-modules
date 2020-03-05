variable "deploy" {
  default = true
}

variable name_prefix {
  description = "Prefix to use when naming resources"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {
    "Managed by" : "Terraform"
    }
}

variable rule_sqli_action {
  default     = "BLOCK"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}