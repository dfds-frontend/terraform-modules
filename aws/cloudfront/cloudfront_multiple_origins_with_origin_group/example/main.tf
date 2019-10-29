//variables here are defined for the sole purpose of ensuring terraform.tfvars and parent modules using this module invocation can pass values into the variables defined by the module invocation in this file 
variable aliases {
  description = "Aliases, or CNAMES, for the distribution"
  type        = list
  default     = []
}

variable comment {
  description = "A short unique description of the cloudfront distribution. Comments used to enable the user to distinquish between cloudfront distributions. It's also used to construct a proper prefix for any lambda@edge functions needed."
  type        = string
  default     = ""
}

variable dynamic_custom_error_response {
  description = "Custom error response to be used in dynamic block"
  type = any
}

variable dynamic_custom_origin_config {
  description = "Configuration for the custom origin config to be used in dynamic block"
  type = any
}

variable dynamic_default_cache_behavior {
  description = "Default Cache Behviors to be used in dynamic block"
  type = any
}

variable dynamic_ordered_cache_behavior {
  description = "Ordered Cache Behaviors to be used in dynamic block"
  type = any
}

variable dynamic_s3_origin_config {
  description = "Configuration for the s3 origin config to be used in dynamic block"
  type = list(map(string))
}

variable enable {
  description = "Whether the distribution is enabled to accept end user requests for content"
  type        = string
  default     = true
}

variable enable_ipv6 {
  description = "Whether the IPv6 is enabled for the distribution"
  type        = string
  default     = true
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
}

variable price {
  description = "The price class of the CloudFront Distribution.  Valid types are PriceClass_All, PriceClass_100, PriceClass_200"
  type        = string
  default     = "PriceClass_100"
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

variable tag_name {
  description = "The tagged name"
  type        = string
}

variable webacl {
  description = "The WAF Web ACL"
  type        = string
  default     = ""
}


terraform {
  backend "s3" {
  }
}

module dfds_cloudfront_resource_usemodule {
  //source                         = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/cloudfront" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  source                         = "./../"
  aliases                        = "${var.aliases}"
  comment                        = "${var.comment}"
  dynamic_custom_error_response  = "${var.dynamic_custom_error_response}"
  dynamic_default_cache_behavior = "${var.dynamic_default_cache_behavior}"
  enable                         = "${var.enable}"
  enable_ipv6                    = "${var.enable_ipv6}"
  http_version                   = "${var.http_version}"
  dynamic_ordered_cache_behavior = "${var.dynamic_ordered_cache_behavior}"
  dynamic_custom_origin_config   = "${var.dynamic_custom_origin_config}"
  dynamic_s3_origin_config       = "${var.dynamic_s3_origin_config}"  
  price                          = "${var.price}"
  restriction_type               = "${var.restriction_type}"
  viewer_certificate             = {
    cloudfront_default_certificate = true
  }
  /* left as example of specifying an certificate
  viewer_certificate             = {
    acm_certificate_arn = "arn:aws:acm:eu-central-1:378906186090:certificate/4f1155c2-dee5-4ea3-b5ea-fdb1c81d8543"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
  */
  tag_name                       = "${var.tag_name}"
  webacl                         = "${var.webacl}"
}