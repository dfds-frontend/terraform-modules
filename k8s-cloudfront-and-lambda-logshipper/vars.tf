variable "env" {

}

variable "namespace" {

}

variable "s3_access_iam_role_arn" {
}

variable "s3_log_source"{

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
   default = false 
}

variable "lambda_log_prefix" {
   default = null
}

variable "cloudfront_log_prefix" {
   default = null
}

variable "delete_lambda_log_source_files" {
   default = false
}

variable "delete_cloudfront_log_source_files" {
   default = false
}

variable "logshipper_container_cpu_limit" {
   default = "250m"
}

variable "logshipper_container_memory_limit" {
   default = "1536Mi"
}

variable "logshipper_container_cpu_request" {
   default = "250m"
}

variable "logshipper_container_memory_request" {
   default = "1536Mi"
}