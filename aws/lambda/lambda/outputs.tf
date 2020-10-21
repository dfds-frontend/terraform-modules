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
  description = "Use this instead lambda_function_arn when intending to use specific published version of lambda"
  value = "${aws_lambda_function.lambda.qualified_arn}"
}

output "lambda_function_latest_published_version" {
  value = "${aws_lambda_function.lambda.version}"
}

output "lambda_iam_role_name" {
  value = "${aws_iam_role.role.name}"
}

output "lambda_iam_role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "log_group_arn" {
  value = "${aws_cloudwatch_log_group.log_group.arn}"
}

output "log_group_name" {
  value = local.log_group_name
}


output "lambda_alias_arn" {
    value = aws_lambda_alias.lambda.arn
}

output "lambda_alias_invoke_arn" {
    value = aws_lambda_alias.lambda.invoke_arn
}