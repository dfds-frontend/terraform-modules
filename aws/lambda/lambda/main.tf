terraform {
  required_version = "~> 0.12.2"
}

locals {
  use_zipfile_as_source = var.zipfilename != null ? true : false
  log_group_name = "/aws/lambda/${var.name}"
}

resource "aws_lambda_function" "lambda" {
  function_name = "${var.name}"
  source_code_hash = "${local.use_zipfile_as_source ? var.source_code_hash : data.archive_file.lambda_zip[0].output_base64sha256}"
  role          = "${aws_iam_role.role.arn}"
  handler       = "${var.lambda_function_handler}.handler"
  runtime       = "${var.runtime}"
  filename = "${local.use_zipfile_as_source ? var.zipfilename : data.archive_file.lambda_zip[0].output_path}"
  publish = "${var.publish}"
  timeout = "${var.timeout}"
  memory_size = "${var.memory_size}"
  
  dynamic "environment" {
    for_each = length(keys(var.lambda_env_variables)) > 0 ? [1]: []

    content {
      variables = "${var.lambda_env_variables}"
    }
  }
  tags = var.tags
}

resource "aws_iam_role" "role" {
  name = "${var.name}"
  force_detach_policies = var.force_detach_policies
 
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

data "aws_iam_policy_document" "cloudwatch_logs" {
  statement {
    effect = "Allow"

    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

data "aws_iam_policy_document" "firehose_reingesting" {
  count = var.isFirehoseProcessor ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["firehose:PutRecordBatch"]

    resources = [
      var.target_firehose_arn
    ]
  }
}

resource "aws_iam_role_policy" "cloudwatch_logs" {
  name = "cw-log-access"
  role = "${aws_iam_role.role.name}"
  policy = data.aws_iam_policy_document.cloudwatch_logs.json
}

resource "aws_iam_role_policy" "firehose_reingesting" {
  count = var.isFirehoseProcessor ? 1 : 0
  name = "firehose-firehose-reingesting"
  role = "${aws_iam_role.role.name}"
  policy = data.aws_iam_policy_document.firehose_reingesting[0].json
}

data "archive_file" "lambda_zip" {
    count = local.use_zipfile_as_source ? 0 : 1
    type        = "zip"
    source_file  = "${var.filename}"
    source_dir  = "${var.directory_name}"
    output_path = var.filename != null ? "${var.filename}.zip" : "${var.directory_name}.zip"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = local.log_group_name
  retention_in_days = 30
  tags = var.tags
}

resource "aws_lambda_alias" "lambda" {
  name             =  "${var.name}"
  description      = "Version ${aws_lambda_function.lambda.version}"
  function_name    = var.name
  function_version = aws_lambda_function.lambda.version
}