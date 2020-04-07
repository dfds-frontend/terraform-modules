variable "name" {
  
}
variable "enable_processing_configuration" {
  
}
variable "processor_lambda_arn" {
  
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