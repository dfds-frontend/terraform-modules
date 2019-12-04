variable "lambda_function_name" {
    type = string
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

variable "filename" {
  description = "Path for the object to upload to lambda function."
}