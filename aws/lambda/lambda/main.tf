terraform {
  required_version = "~> 0.12.2"
}

locals {
  use_zipfile_as_source = var.zipfilename != null ? true : false
  cloudwatch_logs_policy_actions = var.allow_create_loggroup ? ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"] : ["logs:CreateLogStream", "logs:PutLogEvents"]
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

    actions = "${local.cloudwatch_logs_policy_actions}"

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_role_policy" "cloudwatch_logs" {
  name = "${var.name}"
  role = "${aws_iam_role.role.name}"
  policy = data.aws_iam_policy_document.cloudwatch_logs.json
}

data "archive_file" "lambda_zip" {
    count = local.use_zipfile_as_source ? 0 : 1
    type        = "zip"
    source_file  = "${var.filename}"
    source_dir  = "${var.directory_name}"
    output_path = var.filename != null ? "${var.filename}.zip" : "${var.directory_name}.zip"
}