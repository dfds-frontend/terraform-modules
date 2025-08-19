variable "domain_name" {
  description = "The domain name for the CloudFront distribution. This is the domain that users will use to access the content served by CloudFront."
  type        = string
  default     = null
}

variable "comment" {
  type        = string
  description = "A short description of the cloudfront distribution. Comments used to enable the user to distinquish between cloudfront distributions."
  default     = ""
}

variable "cache_behavior_allowed_methods" {
  type        = list(string)
  description = "Controls which HTTP methods CloudFront processes and forwards to the origin."
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cache_behavior_cached_methods" {
  type        = list(string)
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  default     = ["GET", "HEAD"]
}



variable "logging_enable" {
  type        = bool
  description = "Enable/Disable Cloudfront access logs."
  default     = false
}

variable "logging_include_cookies" {
  type        = bool
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
  type    = bool
  default = false
}

variable "viewer_request_lambda_edge_function_arn" {
  type    = string
  default = null
}

variable "viewer_request_lambda_edge_function_include_body" {
  type    = bool
  default = false
}

variable "wait_for_deployment" {
  type        = bool
  default     = true
  description = "If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process."
}

variable "custom_error_responses" {
  type = list(object({
    error_caching_min_ttl = number
    error_code            = number
    response_code         = number
    response_page_path    = string
  }))
}

##############################################################################################################################
# Cache control settings
# More info: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html#expiration-individual-objects
##############################################################################################################################
variable "cache_behavior_min_ttl" {
  type        = number
  description = "The default minimum amount of time (seconds) to cache objects in Cloudfront. Default is no cache."
  default     = 0
}

variable "cache_behavior_default_ttl" {
  type        = number
  description = "If the origin does not add a Cache-Control max-age directive to objects, then CloudFront caches objects for the value of the CloudFront default TTL (no cache)."
  default     = 0
}

variable "cache_behavior_max_ttl" {
  type        = number
  description = "The maximum amount of time (seconds) to cache objects in Cloudfront. If header value is default as follows; Expires > maximum TTL then CloudFront caches objects for the value of the CloudFront maximum TTL."
  default     = 31536000
}
