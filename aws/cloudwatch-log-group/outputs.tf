output "arn" {
  value = aws_cloudwatch_log_group.log_group[0].arn
}

output "name" {
  value = var.name
}
