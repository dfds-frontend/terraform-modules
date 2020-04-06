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

    # tags = "${var.tags}"  

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

# resource "aws_iam_role" "firehose_role" {
#   name = "${var.name}-firehose-role"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "firehose.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

resource "aws_iam_role" "firehose_role" {
  name               = "${var.name}-firehose-role"
  assume_role_policy = data.aws_iam_policy_document.kinesis_firehose_stream_assume_role.json
}

resource "aws_iam_role_policy" "kinesis_firehose_access_bucket_policy" {
  name   = "kinesis_firehose_access_bucket_policy"
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