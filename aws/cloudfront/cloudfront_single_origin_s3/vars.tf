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
  type        = string
  default     = null
}

variable "logging_prefix" {
  description = "Folder path inside s3 bucket where Cloudfront access logs will be stored."
  type        = string
  default     = null
}

variable "origin_request_lambda_edge_function_arn" {
  type    = string
  default = null
}

variable "origin_request_lambda_edge_function_include_body" {
  default = false
}

variable "viewer_request_lambda_edge_function_arn" {
  type    = string
  default = null
}

variable "viewer_request_lambda_edge_function_include_body" {
  default = false
}

variable "wait_for_deployment" {
  default     = true
  description = "If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process."
}

variable "custom_error_response_error_caching_min_ttl" {
  default = 5
}

variable "custom_error_response_code" {
  type = string
}

variable "custom_error_response_page_path" {
  description = "Path should be in this format {something}/{applcation_name}/{path_to_error_html_page_inside_s3_bucket}. Example: /error-pages/portal/index.html"
  type        = string
}


##############################################################################################################################
# Cache control settings
# More info: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html#expiration-individual-objects
##############################################################################################################################
variable "cache_behavior_min_ttl" {
  description = "The default minimum amount of time (seconds) to cache objects in Cloudfront. Default is 0 seconds."
  default     = 0
}

variable "cache_behavior_default_ttl" {
  description = "If the origin does not add a Cache-Control max-age directive to objects, then CloudFront caches objects for the value of the CloudFront default TTL (no cache)"
  default     = 0
}

variable "cache_behavior_max_ttl" {
  description = "The maximum amount of time (seconds) to cache objects in Cloudfront. If header value is default as follows; Expires > maximum TTL then CloudFront caches objects for the value of the CloudFront maximum TTL."
  default     = 31536000
}
