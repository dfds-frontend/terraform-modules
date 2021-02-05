output "aws_cw_log_destination_arn" {
  value = aws_cloudwatch_log_destination.destination_firehose.arn
}