variable prefix {
  description = "A prefix appended to varius parts, to help recognizing resource coherence."
  type        = string
  default     = "example-ecosystem"
}

variable dynamic_custom_error_response {
  description = "Custom error response to be used in dynamic block"
  type = any
  default = []
}

variable dynamic_custom_origin_config {
  description = "Configuration for the custom origin config to be used in dynamic block"
  type = any
  default = []
}

variable dynamic_default_cache_behavior {
  description = "Default Cache Behviors to be used in dynamic block"
  type = any
}

variable dynamic_ordered_cache_behavior {
  description = "Ordered Cache Behaviors to be used in dynamic block"
  type = any
  default = []
}

variable dynamic_s3_origin_config {
  description = "Configuration for the s3 origin config to be used in dynamic block"
  type = list(map(string))
  default = []
}

variable retain_on_delete {
  description = "If true then the distribution is disabled instead of deleted, when destroying the resource through Terraform. - leaving the resource deletion up to a manual process."
  type        = bool
  default     = false 
}

variable tag_name {
  description = "The tagged name"
  type        = string
  default     = ""
}