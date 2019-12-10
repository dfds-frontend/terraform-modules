variable "api_gateway_rest_api_name" {
  # dfds-cf-api
}

# Variables
# variable "aws_region" {}

variable "lambda_function_invoke_arn" {
  
}

variable "lambda_function_name" {
  # "api-root-redirect-role-${var.environment}"
}

# while it's possible to create one stage per environment we'll only 
# create one named LATEST
variable "api_gateway_stage" {
  default = "LATEST" 
}