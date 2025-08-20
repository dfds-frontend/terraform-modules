# trunk-ignore-all(checkov/CKV_AWS_158)
resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.deploy ? 1 : 0
  name              = var.name
  tags              = var.tags
  retention_in_days = var.retention_days
}
