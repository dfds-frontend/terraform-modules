terraform {
  required_version = "~> 0.12.2"
}

resource "aws_cloudwatch_log_group" "log_group" {
  count = var.deploy ? 1 : 0
  name = "${var.name}"
  
  tags = "${var.tags}"

  retention_in_days = "${var.retention_days}"
}