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

variable "log_level" {
  description = "Log level settings, set one of DEBUG, INFO, WARNING, ERROR, CRITICAL"
  default     = "INFO"
}

variable "rule_reputation_lists_protection_action" {
  default     = "COUNT"
}


variable "aws_region" {}


variable "waf_blacklist_ipset" {
  description = "Provide waf blacklist to deny accessing web resources"
  type = list(string)

  default = [ ]
}

variable "reputation_lists_protection_lambda_source" {
  
}


variable "rule_blacklist_action" {
  default = "COUNT"
}
