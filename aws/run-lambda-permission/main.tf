resource "aws_lambda_permission" "this" {
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = var.principal
  source_arn    = var.source_arn
  qualifier     = aws_lambda_alias.lambda.name
}

resource "aws_lambda_alias" "lambda" {
  name             = "version"
  description      = "Version ${var.lambda_version}"
  function_name    = var.lambda_name
  function_version = var.lambda_version
}