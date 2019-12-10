terraform {
  backend "s3" {}
}

provider "aws" { # default 
  region  = "eu-central-1"
  version = "~> 2.28.1"
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.28.1"
  alias = "us-east-1"
}

module "aws_cloudfront_app" {
  source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/cloudfront/cloudfront_single_origin_http?ref=v0.8.0"
  comment = "${local.infrastructure_identifier}"
  domain_name = "${var.origin_domain_name}"
  logging_enable = "${var.cf_dist_logging_enable}"
  logging_include_cookies = false
  logging_bucket = "${module.aws_s3-logging.bucket_domain_name}"
  logging_prefix = "cf_logs"
  #===========================================================================#
  # Before removing lambda resource or destroying resources: 
  #   1) Disable the following lines and run apply. 
  #   2) Wait about 1 hour or wait until Cloudfront change status to Deployed. 
  request_lambda_edge_function_arn = "${module.aws_lambda_edge_behavior_default.lambda_function_qualified_arn}"
  request_lambda_edge_function_include_body = false
  #===========================================================================#
  wait_for_deployment             = "${var.cf_dist_wait_for_deployment}"

  custom_error_responses = [{
    error_caching_min_ttl = 5
    error_code = 404
    response_code = 404
    response_page_path = "/index.html"
  }]

  cache_behavior_min_ttl          = 0
  cache_behavior_default_ttl      = 0
  cache_behavior_max_ttl          = 0
}

module "aws_lambda_edge_behavior_default" {
  source                  = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/lambda/lambda_edge?ref=v0.8.0"
  lambda_function_name    = "${local.safe_infrastructure_identifier}"
  lambda_role_name        = "${local.safe_infrastructure_identifier}"
  lambda_function_handler = "redirect-rules"  # filename without extension
  filename                = "${local.lambda_filename}"
  publish                 = true

  providers = {
    aws = "aws.us-east-1" # lambda@edge must be created in us-east-1 region
  }
}


module "aws_s3-logging" {
  source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket?ref=v0.8.0"
  deploy = "${var.cf_dist_logging_enable}"
  s3_bucket = "${local.safe_infrastructure_identifier}-logging"
  enable_versioning = false
  enable_destroy = true
  enable_retention_policy = true
  retention_days = 120
  bucket_canned_acl = "private"
}
