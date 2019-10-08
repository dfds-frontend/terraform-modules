variable "comment" {
  description = "A short description of the cloudfront distribution. Comments used to enable the user to distinquish between cloudfront distributions. It's also used to construct a proper prefix for lambda@edge function."
  default = ""
}
variable "aliases" {
  default = []
  type = "list"
  description = "The list of custom domains to be used to reach the cloudfront distribution instead of the auto-generated cloudfront domain (xxxx.cloudfront.net)."
}

variable "logging_enable" {
  default = false
}

variable "logging_include_cookies" {
  description = "Specifies whether you want CloudFront to include cookies in access logs (default: false)"
  default = false
}


variable "logging_bucket" {
  description = "S3 bucket for CloudFront access logs"
  default = ""
}

variable "logging_prefix" {
  description = "Name of the folder inside the S3 bucket that will be created for the access logs"
  default = ""
}

variable "default_origin_domain_name" {  
}

variable "default_origin_id" {
  
}

variable "request_lambda_edge_function_arn" {
  default = ""
}

variable "request_lambda_edge_function_include_body" {
  default = false
}

variable "origin_access_identity" {
  default = ""
  description = "The path that identifies the origin access identity to be used for accessing s3 bucket origins."
}