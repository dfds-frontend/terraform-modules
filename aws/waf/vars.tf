variable "name_prefix" {
  type        = string
  description = "Prefix to use when naming resources"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {
    "Managed by" : "Terraform"
  }
}

variable "rule_sqli_action" {
  type        = string
  default     = "BLOCK"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  validation {
    condition     = contains(["BLOCK", "ALLOW", "COUNT"], var.rule_sqli_action)
    error_message = "Rule action must be one of BLOCK, ALLOW, COUNT."
  }
}

variable "rule_xss_action" {
  type        = string
  default     = "BLOCK"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  validation {
    condition     = contains(["BLOCK", "ALLOW", "COUNT"], var.rule_xss_action)
    error_message = "Rule action must be one of BLOCK, ALLOW, COUNT."
  }
}

variable "rule_http_flood_action" {
  type        = string
  default     = "BLOCK"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  validation {
    condition     = contains(["BLOCK", "ALLOW", "COUNT"], var.rule_http_flood_action)
    error_message = "Rule action must be one of BLOCK, ALLOW, COUNT."
  }
}

variable "rule_blacklist_action" {
  type        = string
  default     = "BLOCK"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  validation {
    condition     = contains(["BLOCK", "ALLOW", "COUNT"], var.rule_blacklist_action)
    error_message = "Rule action must be one of BLOCK, ALLOW, COUNT."
  }
}

variable "rule_whitelist_action" {
  type        = string
  default     = "ALLOW"
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  validation {
    condition     = contains(["BLOCK", "ALLOW", "COUNT"], var.rule_whitelist_action)
    error_message = "Rule action must be one of BLOCK, ALLOW, COUNT."
  }
}

variable "log_level" {
  type        = string
  description = "Log level settings, set one of DEBUG, INFO, WARNING, ERROR, CRITICAL"
  default     = "INFO"
  validation {
    condition     = contains(["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"], var.log_level)
    error_message = "Log level must be one of DEBUG, INFO, WARNING, ERROR, CRITICAL."
  }
}

variable "rule_reputation_lists_protection_action" {
  type        = string
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  default     = "BLOCK"
}

variable "waf_blacklist_ipset" {
  type        = list(string)
  description = "Provide waf blacklist to deny access to web resources"
  default     = []
}

variable "waf_whitelist_ipset" {
  type        = list(string)
  description = "Provide waf whitelist to accept access to web resources"
  default     = []
}

variable "reputation_lists_protection_lambda_source" {
  type = string
}

variable "waf_http_flood_rate_limit" {
  type    = number
  default = 1000
}
