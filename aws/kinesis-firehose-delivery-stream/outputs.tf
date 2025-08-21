output "arn" {
  value = aws_kinesis_firehose_delivery_stream.delivery_stream.arn
}


output "cloudwatch_logs_role_arn" {
  value = aws_iam_role.cloudwatch_logs_role.arn
}
