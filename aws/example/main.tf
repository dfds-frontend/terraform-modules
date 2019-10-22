terraform {
  backend "s3" {
  }
}

variable region {
  description = "Target AWS region"
  type        = string
  default     = "us-east-1"
}

locals {
  infrastructure_identifier = "Capability Cloudfront Identifier"
  safe_infrastructure_identifier = "${replace(lower(local.infrastructure_identifier), " ", "-")}"
}

/* Cloudfront Section Variables - Start
 * Only defined vars are the ones getting input in the current example
\*/
variable cloudfront_comment {
  description = "A short unique description of the cloudfront distribution. Comments used to enable the user to distinquish between cloudfront distributions. It's also used to construct a proper prefix for any lambda@edge functions needed."
  type        = string
  default     = ""
}

variable cloudfront_dynamic_custom_origin_config {
  description = "Configuration for the custom origin config to be used in dynamic block"
  type = any
}

variable cloudfront_dynamic_default_cache_behavior {
  description = "Default Cache Behviors to be used in dynamic block"
  type = any
}

variable cloudfront_dynamic_ordered_cache_behavior {
  description = "Ordered Cache Behaviors to be used in dynamic block"
  type = any
}


variable cloudfront_ssl_certificate {
  description = "Specifies IAM certificate id for CloudFront distribution"
  type        = string
}

variable cloudfront_ssl_support_method {
  description = "Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only."
  type        = string
}

variable cloudfront_tag_name {
  description = "The tagged name"
  type        = string
}

variable cloudfront_webacl {
  description = "The WAF Web ACL"
  type        = string
  default     = ""
}

variable "cloudfront_dynamic_logging_config" {
  description = "lets align with orig. desc. etc. later :)"
  type = any
  default = []
}

/*
cloudfront_dynamic_logging_config = [{
    bucket = module.aws_s3_bucket_resource_usemodule.bucket_domain_name
    include_cookies = true
    prefix = "${local.safe_infrastructure_identifier}"
    }]
*/

/* Cloudfront Section Variables - End
\*/


/* S3 Bucket Section Variables - Start
 * Only defined vars are the ones getting input in the current example
\*/

variable "s3bucket_enable_destroy" {
  default = false
}
variable "s3bucket_enable_retention_policy" {
  default = true
}
variable "s3bucket_s3_bucket_name"{
  default = "logging-bucket"
}

variable "s3bucket_retention_days" {
  default = 90
}

variable "s3bucket_bucket_canned_acl" {
  default = "log-delivery-write"
}

/* S3 Bucket Section Variables - End
\*/

module dfds_cloudfront_resource_use_of_module {
  //source                         = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/cloudfront" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  source                         = "./../cloudfront/"
  comment                        = "${local.infrastructure_identifier}"
  dynamic_custom_origin_config   = "${var.cloudfront_dynamic_custom_origin_config}"
  dynamic_default_cache_behavior = "${var.cloudfront_dynamic_default_cache_behavior}"
  dynamic_ordered_cache_behavior = "${var.cloudfront_dynamic_ordered_cache_behavior}"  
  region                         = "${var.region}"
  ssl_certificate                = "${var.cloudfront_ssl_certificate}"
  ssl_support_method             = "${var.cloudfront_ssl_support_method}"
  tag_name                       = "${var.cloudfront_tag_name}"
  webacl                         = "${var.cloudfront_webacl}"
  dynamic_logging_config         = [{
    bucket = module.aws_s3_bucket_resource_usemodule.bucket_domain_name
    include_cookies = true
    prefix = "${local.safe_infrastructure_identifier}"
    }]
}

module "aws_s3_bucket_resource_usemodule" {
  //source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  source = "./../s3-bucket/"
  s3_bucket = "${var.s3bucket_s3_bucket_name}-${local.safe_infrastructure_identifier}"
  enable_versioning = false
  enable_destroy = var.s3bucket_enable_destroy
  enable_retention_policy = var.s3bucket_enable_retention_policy
  retention_days = var.s3bucket_retention_days
  bucket_canned_acl = var.s3bucket_bucket_canned_acl
}