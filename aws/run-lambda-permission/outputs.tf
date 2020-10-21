output "aws_lambda_alias_arn" {
    value = aws_lambda_alias.lambda.arn
}

output "aws_lambda_alias_invoke_arn" {
    value = aws_lambda_alias.lambda.invoke_arn
}