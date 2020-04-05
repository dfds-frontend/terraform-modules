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
  default = false
  description = "Enable publishing under a new version. This is required when enabling in order to enable lambda function to be used by cloudfront."
}


variable "filename" {
  description = <<TEXT
  Path to the file that contains source code to upload to lambda function. It connot be used with the following:
      directory_name
      zipfilename
      source_code_hash
    TEXT

  type = string
  default = null
}

variable "directory_name" {
  description = <<TEXT
    Path to the directory the contains source files to upload to lambda function. It connot be used with the following:
      filename
      zipfilename
      source_code_hash
    TEXT

  type = string
  default = null
}

variable "zipfilename" {
  description = "Path to zip file containing the source files to upload to lambda function. It should be used along with zipfilename"
  type = string
  default = null
}

variable "source_code_hash" {
  description = "The hash string generated for zipfile source, that Terraform uses to determine whether to uploade a new code to lambda function. It can only be used with zipfilename"
  type = string
  default = null  
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {
    "Managed by" : "Terraform"
    }
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3."
  default = null
}
