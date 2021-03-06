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

variable "rule_xss_action" {
  default     = "BLOCK"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}

variable "rule_http_flood_action" {
  default     = "BLOCK"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}

variable "rule_blacklist_action" {
  default = "BLOCK"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}

variable "rule_whitelist_action" {
  default = "ALLOW"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
}

variable "log_level" {
  description = "Log level settings, set one of DEBUG, INFO, WARNING, ERROR, CRITICAL"
  default     = "INFO"
}

variable "rule_reputation_lists_protection_action" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  default     = "BLOCK"
}


variable "aws_region" {}


variable "waf_blacklist_ipset" {
  description = "Provide waf blacklist to deny access to web resources"

  default = []
}

variable "waf_whitelist_ipset" {
  description = "Provide waf whitelist to accept access to web resources"

  default = []
}

variable "reputation_lists_protection_lambda_source" {
  
}

variable "waf_http_flood_rate_limit" {
  default = 1000
}