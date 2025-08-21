variable "lambda_arn" {
  type = string
}

variable "bucket_id" {
  type = string
}

variable "src_prefix" {
  type        = string
  default     = ""
  description = "Prefix for files which will trigger the lambda function. Use to only process a single directory within the source bucket"
}
