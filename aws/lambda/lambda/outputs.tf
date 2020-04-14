output "lambda_function_arn" {
  value = "${aws_lambda_function.lambda.arn}"
}

output "lambda_function_name" {
  value = "${var.name}"
}

output "lambda_function_invoke_arn" {
  value = "${aws_lambda_function.lambda.invoke_arn}"
}

output "lambda_function_qualified_arn" {
  value = "${aws_lambda_function.lambda.qualified_arn}"
}

output "lambda_function_latest_published_version" {
  value = "${aws_lambda_function.lambda.version}"
}