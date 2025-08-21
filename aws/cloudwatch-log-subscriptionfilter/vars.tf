variable "name" {
  description = "The name of the CloudWatch log subscription filter."
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that CloudWatch Logs assumes when delivering log events."
  type        = string
  default     = null
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group."
  type        = string
  default     = null
}

variable "filter_pattern" {
  description = "The filter pattern for the subscription filter."
  type        = string
  default     = null
}

variable "destination_arn" {
  description = "The ARN of the destination to send log events to."
  type        = string
  default     = null
}

variable "distribution" {
  description = "The distribution of the subscription filter."
  type        = string
  default     = null
}
