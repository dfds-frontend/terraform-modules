locals {
  s3bucket_origin_id = "s3bucket_app"
}

module "aws_cf_dist_s3" {
  source = "../cloudfront_multiple_origins"
  origins = [{
    is_s3_origin = true
    domain_name  = var.s3_bucket_domain_name
    origin_id    = local.s3bucket_origin_id
  }]
  default_cache_behavior = {
    allowed_methods                                     = ["GET", "HEAD"]
    cached_methods                                      = ["GET", "HEAD"]
    origin_id                                           = local.s3bucket_origin_id
    forwarded_values_query_string                       = false
    forwarded_values_cookies_forward                    = "none"
    lambda_function_association_origin_req_lambda_arn   = var.origin_request_lambda_edge_function_arn
    lambda_function_association_origin_req_include_body = var.origin_request_lambda_edge_function_include_body
    lambda_function_association_viewer_req_lambda_arn   = var.viewer_request_lambda_edge_function_arn
    lambda_function_association_viewer_req_include_body = var.viewer_request_lambda_edge_function_include_body
    min_ttl                                             = var.cache_behavior_min_ttl
    default_ttl                                         = var.cache_behavior_default_ttl
    max_ttl                                             = var.cache_behavior_max_ttl
  }

  custom_error_responses = [{
    error_caching_min_ttl = var.custom_error_response_error_caching_min_ttl
    error_code            = "403"
    response_code         = var.custom_error_response_code
    response_page_path    = var.custom_error_response_page_path
  }]

  comment                 = var.comment
  origin_access_identity  = var.origin_access_identity
  logging_enable          = var.logging_enable
  logging_include_cookies = var.logging_include_cookies
  logging_bucket          = var.logging_bucket
  logging_prefix          = var.logging_prefix
  wait_for_deployment     = var.wait_for_deployment
}
