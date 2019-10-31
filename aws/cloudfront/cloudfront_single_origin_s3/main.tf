locals {
  s3bucket_origin_id = "s3bucket_app"
}

module "aws_cf_dist_s3" {
    source = "../cloudfront_multiple_origins"
    origins = [{
        is_s3_origin = true
        domain_name = var.s3_bucket_domain_name
        origin_id = "${local.s3bucket_origin_id}"
        lambda_function_association_lambda_arn = "${var.request_lambda_edge_function_arn}"
        lambda_function_association_include_body = "${var.request_lambda_edge_function_include_body}"
    }]
    default_cache_behavior = {
        allowed_methods = ["GET", "HEAD"]
        cached_methods = ["GET", "HEAD"]
        origin_id = "${local.s3bucket_origin_id}"
        forwarded_values_query_string = false
        forwarded_values_cookies_forward = "none"
    }
    comment = "${var.comment}"
    origin_access_identity = "${var.origin_access_identity}"
    logging_enable = "${var.logging_enable}"
    logging_include_cookies = "${var.logging_include_cookies}"
    logging_bucket = "${var.logging_bucket}"
    logging_prefix = "${var.logging_prefix}"
    wait_for_deployment = "${var.wait_for_deployment}"
}
