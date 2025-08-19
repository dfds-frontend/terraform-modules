variable "name_prefix" {
  description = "A prefix to be prepended to all resource names created by this module."
  type        = string
  default     = ""
}

variable "cloudwatch_event_target_id" {
  description = "The ID of the CloudWatch event target."
  type        = string
  default     = null
}

variable "cloudwatch_event_target_arn" {
  description = "The ARN of the CloudWatch event target."
  type        = string
  default     = null
}

variable "event_input" {
  description = "json formatted input"
  type        = string
  default     = null
}

variable "event_schedule" {
  type        = string
  description = <<TEXT
        Format: rate(<x> <UNIT>)
        Examples:
            rate(5 minutes)
            rate(1 hour)
        For more info: https://docs.aws.amazon.com/lambda/latest/dg/services-cloudwatchevents-expressions.html
   TEXT
}
