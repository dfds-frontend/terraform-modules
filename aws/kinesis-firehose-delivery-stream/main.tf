terraform {
  required_version = "~> 0.12.2"
}
resource "aws_kinesis_firehose_delivery_stream" "delivery_stream" {
  name        = "${var.name}-kinesis-firehose" #"terraform-kinesis-firehose-extended-s3-test-stream"
  destination = "extended_s3"
  tags = "${var.tags}"

  extended_s3_configuration {
    role_arn   = "${aws_iam_role.firehose_role.arn}"
    bucket_arn = "${var.bucket_arn}"
    prefix = "${var.extra_prefix}"
    buffer_size = "${var.buffer_size}"
    buffer_interval = "${var.buffer_interval}"
    error_output_prefix = "${var.error_output_prefix}"

    processing_configuration {
      enabled = "${var.enable_processing_configuration}" #"true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${var.processor_lambda_arn}:$LATEST" #"${aws_lambda_function.lambda_processor.arn}:$LATEST"
        }
      }
    }
  }
}

resource "aws_iam_role" "firehose_role" {
  name               = "${var.name}-firehose-role"
  assume_role_policy = data.aws_iam_policy_document.kinesis_firehose_stream_assume_role.json
}

resource "aws_iam_role_policy" "kinesis_firehose_access_bucket_policy" {
  name   = "${var.name}-firehose-access-bucket-policy"
  role   = aws_iam_role.firehose_role.name
  policy = data.aws_iam_policy_document.kinesis_firehose_access_bucket_assume_policy.json
}

data "aws_iam_policy_document" "kinesis_firehose_stream_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "kinesis_firehose_access_bucket_assume_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    resources = [
      "${var.bucket_arn}",
      "${var.bucket_arn}/*",
    ]
  }
}


## TODO: Check and test!!

data "aws_iam_policy_document" "lambda_assume_policy" {
  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
      "lambda:GetFunctionConfiguration",
    ]

    resources = [
      "${var.processor_lambda_arn}:$LATEST",
    ]
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "${var.name}-lambda_function_policy"
  role   = aws_iam_role.firehose_role.name
  policy = data.aws_iam_policy_document.lambda_assume_policy.json
}

# ############################################################
# Allow Cloudwatch resources from different regions 
# such as subscriptionFilter to assume roles on Firehose
# ############################################################
data "aws_iam_policy_document" "cloudwatch_logs_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [for region in var.cloudwatch_source_regions:
        "logs.${region}.amazonaws.com"
        ]

        # ["logs.${length(var.region) > 0 ? var.region : data.aws_region.default.name}.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch_logs_assume_policy" {
  statement {
    effect    = "Allow"
    actions   = ["firehose:*"]
    resources = [aws_kinesis_firehose_delivery_stream.delivery_stream.arn]
  }
}

resource "aws_iam_role" "cloudwatch_logs_role" {
  name               = "${var.name}-firehose_cw_logs_role"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_logs_assume_role.json
}

resource "aws_iam_role_policy" "cloudwatch_logs_policy" {
  name   = "${var.name}-firehose_cw_logs_policy"
  role   = aws_iam_role.cloudwatch_logs_role.name
  policy = data.aws_iam_policy_document.cloudwatch_logs_assume_policy.json
}
