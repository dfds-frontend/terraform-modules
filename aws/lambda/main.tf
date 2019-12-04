terraform {
  required_version = "~> 0.12.2"
}

resource "aws_lambda_function" "lambda" {
  function_name = "${var.lambda_function_name}"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  role          = "${aws_iam_role.role.arn}"
  handler       = "${var.lambda_function_handler}.handler"
  runtime       = "${var.runtime}"
  # filename      = "${var.filename}"
  filename = "lambda.zip"
  publish = "${var.publish}"
  
  dynamic "environment" {
    for_each = length(keys(var.lambda_env_variables)) > 0 ? [1]: []

    content {
      variables = "${var.lambda_env_variables}"
    }
  }
}

resource "aws_iam_role" "role" {
  name = "${var.lambda_role_name}"
 
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com", 
          "edgelambda.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "cloudwatch_logs" {
  name = "${var.lambda_role_name}"
  role = "${aws_iam_role.role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF
}



data "archive_file" "lambda_zip" {
    type        = "zip"
    source_dir  = "${var.filename}"
    output_path = "lambda.zip"
}

# resource "aws_lambda_function" "my_lambda" {
#   filename = "lambda.zip"
#   source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
#   function_name = "my_lambda"
#   role = "${aws_iam_role.lambda.arn}"
#   description = "Some AWS lambda"
#   handler = "index.handler"
#   runtime = "nodejs4.3"


  
#   function_name = "${var.lambda_function_name}"
#   source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
#   role          = "${aws_iam_role.role.arn}"
#   handler       = "${var.lambda_function_handler}.handler"
#   runtime       = "${var.runtime}"
#   filename      = "${var.filename}"
#   publish = "${var.publish}"
  
#   dynamic "environment" {
#     for_each = length(keys(var.lambda_env_variables)) > 0 ? [1]: []

#     content {
#       variables = "${var.lambda_env_variables}"
#     }
#   }  
# }