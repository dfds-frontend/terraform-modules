variable "name" {
  description = "The name of the CloudWatch log destination."
  type        = string
}

variable "cloudwatch_logs_role_arn" {
  description = "The ARN of the IAM role that CloudWatch Logs assumes when delivering log events."
  type        = string
  default     = null
}

variable "target_arn" {
  type        = string
  description = "(optional) describe your variable"
}

variable "allowed_aws_account" {
  type = string
}
