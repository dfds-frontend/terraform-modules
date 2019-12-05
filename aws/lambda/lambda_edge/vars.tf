variable "lambda_function_name" {
  
}

variable "lambda_role_name" {
  description = "Name of iam role to create for the lambda function."
}

variable "lambda_function_handler" {
  description = "The source file without file extension."
}

variable "lambda_env_variables" {
  type = "map"

  default = {}
}

variable "runtime" {
  default = "nodejs10.x"
}

variable "publish" {
  default = true
  description = "Enable publishing under a new version. This is required when enabling in order to enable lambda function to be used by cloudfront."
}


variable "filename" {
  description = "Path for the object to upload to lambda function."
}