variable "s3_bucket_domain_name" {}

variable "comment" {
  description = "A short description of the cloudfront distribution. Comments used to enable the user to distinquish between cloudfront distributions."
  default     = ""
}

variable "origin_access_identity" {
  default     = ""
  description = "The path that identifies the origin access identity to be used for accessing s3 bucket origins."
}

variable "logging_enable" {
  description = "Enable/Disable Cloudfront access logs."
  default     = false
}

variable "logging_include_cookies" {
  description = "Specifies whether you want CloudFront to include cookies in access logs (default: false)"
  default     = false
}

variable "logging_bucket" {
  description = "S3 bucket to be used to store Cloudfront access logs"
}

variable "logging_prefix" {
  description = "Folder path inside s3 bucket where Cloudfront access logs will be stored."
}

variable "request_lambda_edge_function_arn" {
  default = ""
}

variable "request_lambda_edge_function_include_body" {
  default = false
}

variable "wait_for_deployment" {  
  default = true
  description = "If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process."
}

variable "custom_error_response_error_caching_min_ttl" {
  default = 5
}

variable "custom_error_response_code" {
  type = "string"
}

variable "custom_error_response_page_path" {
  description = "Path should be in this format {something}/{applcation_name}/{path_to_error_html_page_inside_s3_bucket}. Example: /error-pages/portal/index.html"
  type = "string"
}

variable "cache_behavior_min_ttl" {
  description = "Default: The minimum cache "
  default = 0 
}

variable "cache_behavior_default_ttl" {
  default = 86400
}

variable "cache_behavior_max_ttl" {
  default = 31536000
}