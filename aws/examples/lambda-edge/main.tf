provider "aws" {
  region = var.aws_region
}

module "lambda-edge-example" {
  source = "../aws/lambda"
  filename = "lambda-example.js"
  lambda_function_handler = "lambda-example"
  lambda_function_name = "lambda-example"
  
}
