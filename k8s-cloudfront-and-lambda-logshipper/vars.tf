variable "env" {

}

variable "namespace" {

}

variable "s3_access_iam_role_arn" {
}

variable "s3_log_source" {

}

variable "s3_log_source_region" {

}

variable "log_server_url" {

}

variable "log_server_username" {

}

variable "log_server_password" {

}

variable "enable_debug" {
  type    = bool
  default = false
}

variable "lambda_log_prefix" {
  type    = string
  default = null
}

variable "cloudfront_log_prefix" {
  type    = string
  default = null
}

variable "delete_lambda_log_source_files" {
  type    = bool
  default = false
}

variable "delete_cloudfront_log_source_files" {
  type    = bool
  default = false
}

variable "logshipper_container_cpu_limit" {
  type    = string
  default = "250m"
}

variable "logshipper_container_memory_limit" {
  type    = string
  default = "1536Mi"
}

variable "logshipper_container_cpu_request" {
  type    = string
  default = "250m"
}

variable "logshipper_container_memory_request" {
  type    = string
  default = "1536Mi"
}
