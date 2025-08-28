variable "name" {
  type        = string
  description = "The name of the Lambda function"
}

variable "force_detach_policies" {
  type    = bool
  default = true
}

variable "lambda_function_handler" {
  type        = string
  description = "The source file without file extension."
}

variable "lambda_env_variables" {
  type = map(any)

  default = {}
}

variable "runtime" {
  type    = string
  default = "nodejs22.x"
}

variable "publish" {
  type        = bool
  default     = false
  description = "Enable publishing under a new version. This is required when enabling in order to enable lambda function to be used by cloudfront."
}


variable "filename" {
  description = <<TEXT
  Path to the file that contains source code to upload to lambda function. It connot be used with the following:
      directory_name
      zipfilename
      source_code_hash
    TEXT

  type    = string
  default = null
}

variable "directory_name" {
  description = <<TEXT
    Path to the directory the contains source files to upload to lambda function. It connot be used with the following:
      filename
      zipfilename
      source_code_hash
    TEXT

  type    = string
  default = null
}

variable "zipfilename" {
  description = "Path to zip file containing the source files to upload to lambda function. It should be used along with zipfilename"
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "The hash string generated for zipfile source, that Terraform uses to determine whether to uploade a new code to lambda function. It can only be used with zipfilename"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {
    "Managed by" : "Terraform"
  }
}

variable "timeout" {
  type        = number
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3."
  default     = null
}

variable "memory_size" {
  type    = number
  default = null
}

variable "isFirehoseProcessor" {
  description = "enables additional configurations for the target Kinesis Firehose setup"
  type        = bool
  default     = false
}
