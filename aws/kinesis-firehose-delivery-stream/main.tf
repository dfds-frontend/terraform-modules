terraform {
  required_version = "~> 0.12.2"
}
resource "aws_kinesis_firehose_delivery_stream" "delivery_stream" {
  name        = "${var.name}-kinesis-firehose" #"terraform-kinesis-firehose-extended-s3-test-stream"
  destination = "extended_s3"
  

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

resource "aws_iam_role" "firehose_role" {
  name = "${var.name}-firehose-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
