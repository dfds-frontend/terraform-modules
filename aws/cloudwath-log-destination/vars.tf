variable name {}

variable cloudwatch_logs_role_arn {}


variable target_arn {
  type = string
  description = "(optional) describe your variable"
}

variable allowed_aws_account {
  type = string
}
