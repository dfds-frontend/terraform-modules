terraform {
  required_version = "~> 0.12.2"
}

resource "aws_cloudwatch_log_subscription_filter" "logfilter" {
  name            = "${var.name}"
  role_arn        = "${var.role_arn}"
  log_group_name  = "${var.log_group_name}"
  filter_pattern  = "${var.filter_pattern}"
  destination_arn = "${var.destination_arn}"
  distribution    = "${var.distribution}"
}