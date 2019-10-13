 /********************************************************************************************************\
|* Variables are ordered in accordance of their order of appearance in the module definition file         *|
|*                                                                                                        *|
|* Default values are defined in order to make usage Out Of The Box, as easy as possible.                 *|
 \********************************************************************************************************/

variable "comment" {
  description = "A short unique description of the cloudfront distribution. Comments used to enable the user to distinquish between cloudfront distributions. It's also used to construct a proper prefix for any lambda@edge functions needed."
  type        = string
  default = "Capability default Cloudfront distribution"
}

variable "aliases" {
  description = "The list of custom domains to be used to reach the cloudfront distribution instead of the auto-generated cloudfront domain (xxxx.cloudfront.net)."
  type = "list"
  default = []
}

variable default_root_object {
  description = "The object that you want CloudFront to return, when the request is for the root URL"
  type        = string
  default     = "index.html"
}

variable dynamic_custom_error_response {
  description = "Custom error response to be used in dynamic block"
  type = any
  default = []
}

variable dynamic_custom_origin_config {
  description = "Configuration for the custom origin config to be used in dynamic block"
  type = any
  default = []
}

variable dynamic_default_cache_behavior {
  description = "Default Cache Behviors to be used in dynamic block"
  type = any
}

variable dynamic_ordered_cache_behavior {
  description = "Ordered Cache Behaviors to be used in dynamic block"
  type = any
  default = []
}

/* Origin groups are not needed currently, hence discared in the resource (it is "optional" in AWS)...
variable dynamic_origin_group {
  description = "Origin Group to be used in dynamic block"
  type = any
}

variable origin_group_member {
  type = any
}
*/

variable dynamic_lambda_function_association_default {
  description = "A config block that triggers a lambda function with specific actions. Defined below, maximum 4.  For Default Cache Behavior block"
  type = any
  default = []
}

variable dynamic_lambda_function_association_ordered {
  description = "A config block that triggers a lambda function with specific actions. Defined below, maximum 4. For Ordered Cache Behavior block"
  type = any
  default = []
}

variable dynamic_logging_config {
  // For explanation on "<<EO" (EO part is convention based) usage see https://www.terraform.io/docs/configuration/expressions.html#string-literals
  description = <<EO_DYNAMIC_LOGGING_CONFIG_DESCRIPTION
    This is the logging configuration for the Cloudfront Distribution.  It is not required.
    If you choose to use this configuration, be sure you have the correct IAM and Bucket ACL rules.
    
    Your tfvars file should follow this syntax:
    
    logging_config = [{
    bucket = "<your-bucket>"
    include_cookies = <true or false>
    prefix = "<your-bucket-prefix>"
    }]

    EO_DYNAMIC_LOGGING_CONFIG_DESCRIPTION

  type    = any
  default = []
}

variable dynamic_s3_origin_config {
  description = "Configuration for the s3 origin config to be used in dynamic block"
  type = list(map(string))
  default = []
}

variable enable {
  description = "Whether the distribution is enabled to accept end user requests for content"
  type        = bool
  default     = true
}

variable enable_ipv6 {
  description = "Whether the IPv6 is enabled for the distribution"
  type        = bool
  default     = false
}

variable http_version {
  description = "The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2"
  type        = string
  default     = "http2"
}

variable minimum_protocol_version {
  description = <<EOF
    The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. 
    One of SSLv3, TLSv1, TLSv1_2016, TLSv1.1_2016 or TLSv1.2_2018. Default: TLSv1. 
    NOTE: If you are using a custom certificate (specified with acm_certificate_arn or iam_certificate_id), 
    and have specified sni-only in ssl_support_method, TLSv1 or later must be specified. 
    If you have specified vip in ssl_support_method, only SSLv3 or TLSv1 can be specified. 
    If you have specified cloudfront_default_certificate, TLSv1 must be specified.
    EOF

  type = string
  default     = "TLSv1"
}

variable price {
  description = "The price class of the CloudFront Distribution. Valid values are PriceClass_All, PriceClass_100, PriceClass_200"
  type        = string
  default     = "PriceClass_100"
}

variable region {
  description = "Target AWS region (used in provider section, not in resource def.) only one is valid, as cloudfront only supports being setup in us-east-1"
  type        = string
  default     = "us-east-1"
}

variable restriction_location {
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)"
  type        = list
  default     = []
}

variable restriction_type {
  description = "The restriction type of your CloudFront distribution geolocation restriction. Options include none, whitelist, blacklist"
  type        = string
  default     = "none"
}

variable retain_on_delete {
  description = "If true then the distribution is disables instead of deleted, when destroying the resource through Terraform. - leaving the resource deletion up to a manual process."
  type        = bool
  default     = false 
}

variable ssl_certificate {
  description = "Specifies IAM certificate id for CloudFront distribution"
  type        = string
}

variable ssl_support_method {
  description = "Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only."
  type        = string
  default     = "sni-only"
}

variable tag_name {
  description = "The tagged name"
  type        = string
  default     = ""
}

variable wait_for_deployment {
  description = "If true(default), the resource will wait for the resource to finish creation (distribution status changes from InProgress to Deployed)."
  type        = bool
  default     = true
}

variable webacl {
  description = "The WAF Web ACL"
  type        = string
  default     = ""
}