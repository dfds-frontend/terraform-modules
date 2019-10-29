module dfds_cloudfront_resource_usemodule {
  //source                         = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/cloudfront" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  source                         = "./../../cloudfront/"
  aliases                        = ["${module.certificate_using_module.imported-certificate-domain_name}"]
  comment                        = "${local.infrastructure_identifier}"
  dynamic_custom_error_response  = "${var.dynamic_custom_error_response}"
  dynamic_default_cache_behavior = "${var.dynamic_default_cache_behavior}"
  enable_ipv6                    = false
  dynamic_ordered_cache_behavior = "${var.dynamic_ordered_cache_behavior}"
  dynamic_custom_origin_config   = "${var.dynamic_custom_origin_config}"
  dynamic_s3_origin_config       = "${var.dynamic_s3_origin_config}"  
  
  dynamic_logging_config         = [{
    bucket = module.aws_s3_bucket_cloudfront_logging.bucket_domain_name
    include_cookies = true
    prefix = "${local.safe_infrastructure_identifier}"
    }]
  
  viewer_certificate             = {
    acm_certificate_arn = "${module.certificate_using_module.imported-certificate-arn}" //"arn:aws:acm:eu-central-1:378906186090:certificate/4f1155c2-dee5-4ea3-b5ea-fdb1c81d8543"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  tag_name                       = "${local.safe_infrastructure_identifier}"
}