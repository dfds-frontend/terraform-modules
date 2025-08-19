resource "aws_cloudwatch_log_destination" "destination_firehose" {
  name       = var.name
  role_arn   = var.cloudwatch_logs_role_arn
  target_arn = var.target_arn
}

data "aws_iam_policy_document" "destination_firehose_policy" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        var.allowed_aws_account,
      ]
    }

    actions = [
      "logs:PutSubscriptionFilter",
    ]

    resources = [
      aws_cloudwatch_log_destination.destination_firehose.arn,
    ]
  }
}

resource "aws_cloudwatch_log_destination_policy" "destination_firehose_policy" {
  destination_name = aws_cloudwatch_log_destination.destination_firehose.name
  access_policy    = data.aws_iam_policy_document.destination_firehose_policy.json
}
