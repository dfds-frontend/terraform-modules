terraform {
  backend "s3" {}
}


resource "aws_cloudwatch_event_rule" "this" {
  name                = "${var.name_prefix}_event_rule"
  is_enabled  = true
  description         = "Run lambda to monitor hosts"
  schedule_expression = var.event_schedule
}

resource "aws_cloudwatch_event_target" "this" {
  rule = aws_cloudwatch_event_rule.this.name
  target_id = var.cloudwatch_event_target_id # if missing then it will generate random
  arn  = var.cloudwatch_event_target_arn

  input = var.event_input
}
