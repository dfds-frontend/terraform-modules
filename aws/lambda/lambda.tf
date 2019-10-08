resource "aws_lambda_function" "lambda" {
  function_name = "${var.lambda_function_name}"
  role          = "${aws_iam_role.role.arn}"
  handler       = "${var.lambda_function_handler}.handler"
  runtime       = "${var.runtime}"
  filename      = "${var.filename}"
  publish = "${var.publish}"
  
  dynamic "environment" {
    for_each = length(keys(var.lambda_env_variables)) > 0 ? [1]: []

    content {
      variables = "${var.lambda_env_variables}"
    }
  }
}