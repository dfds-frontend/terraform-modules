variable "name" {
  type        = string
  description = "The name of the Kinesis Firehose delivery stream"
}

variable "force_detach_policies" {
  type    = bool
  default = true
}

variable "enable_processing_configuration" {
  type    = bool
  default = false
}

variable "processor_lambda_arn" {
  type        = string
  description = "Used when processing configuration is enabled"
  default     = null
}

variable "bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket to deliver the stream to"
}

variable "extra_prefix" {
  type        = string
  description = "An optional prefix to prepend to the S3 object key"
  default     = null
}

variable "buffer_size" {
  type        = number
  description = "The size in MB of the buffer to use for the delivery stream"
  default     = 5
}

variable "buffer_interval" {
  type        = number
  description = "The interval in seconds to wait before delivering the buffer"
  default     = 300
}

variable "error_output_prefix" {
  type        = string
  description = "An optional prefix to prepend to the S3 object key for error output"
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {
    "Managed by" : "Terraform"
  }
}

variable "cloudwatch_source_regions" {
  description = "A list of AWS regions to monitor for CloudWatch logs"
  type        = list(string)
  default     = ["eu-central-1"]
}

variable "lambda_version" {
  description = "Used when processing configuration is enabled"
  type        = string
  default     = null
}
