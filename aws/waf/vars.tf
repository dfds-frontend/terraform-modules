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
  default     = "COUNT"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}

variable "rule_xss_action" {
  default     = "COUNT"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}

variable "rule_http_flood_action" {
  default     = "COUNT"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}





variable "reputation_lists_protection_activated" {
  description = "Activate Reputation List Protection or not"
  default     = "yes"
}


variable "log_level" {
  description = "Log level settings, set one of DEBUG, INFO, WARNING, ERROR, CRITICAL"
  default     = "INFO"
}