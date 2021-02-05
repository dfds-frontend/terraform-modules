variable "name" {
  
}

variable force_detach_policies {
  default = true
}

variable "enable_processing_configuration" {
  default = false
}
variable "processor_lambda_arn" {
  description = "Used when processing configuration is enabled"
  default = null
}
variable "bucket_arn" {
  
}
variable "extra_prefix" {
  
}
variable "buffer_size" {
  
}
variable "buffer_interval" {
  
}
variable "error_output_prefix" {
  
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {
    "Managed by" : "Terraform"
    }  
}

variable "cloudwatch_source_regions" {

  default = ["eu-central-1"]
}

variable "lambda_version" {
  description = "Used when processing configuration is enabled"
  type = string
  default = null
}