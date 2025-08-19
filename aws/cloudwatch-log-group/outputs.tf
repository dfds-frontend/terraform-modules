output "arn" {
  value = aws_cloudwatch_log_group.log_group[count.index].arn
}

output "name" {
  value = var.name
}
