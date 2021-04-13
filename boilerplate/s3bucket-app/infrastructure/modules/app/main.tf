terraform {
  backend "s3" {}
}

provider "aws" {
  region  = "eu-central-1" # default 
  version = "~> 2.28.1"
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.28.1"
  alias   = "us-east-1"
}

module "aws_cloudfront_app" {
  source                  = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/cloudfront/cloudfront_single_origin_s3?ref=v0.9.0"
  comment                 = "${local.infrastructure_identifier}"
  s3_bucket_domain_name   = "${module.aws_s3bucket_app.bucket_domain_name}"
  origin_access_identity  = "${module.aws_cf_oai.origin_access_identity}"
  logging_enable          = "${var.cf_dist_logging_enable}"
  logging_include_cookies = false
  logging_bucket          = "${module.aws_s3bucket_app.bucket_domain_name}"
  logging_prefix          = "cf_logs"
  #===========================================================================#
  # Before removing lambda resource or destroying resources: 
  #   1) Disable the following lines and run apply. 
  #   2) Wait about 1 hour or wait until Cloudfront change status to Deployed. 
  request_lambda_edge_function_arn = "${module.aws_lambda_edge_behavior_default.lambda_function_qualified_arn}"
  request_lambda_edge_function_include_body = false
  #===========================================================================#
  wait_for_deployment             = "${var.cf_dist_wait_for_deployment}"

  #===========================================================================#
  # The following parameters are very application specific and need to be 
  # revised in order to enable a proper error reposne handling
  custom_error_response_page_path = "/router/${local.app_path}/app/index.html"
  custom_error_response_code      = 200
  #===========================================================================#
  cache_behavior_min_ttl          = 0
  cache_behavior_default_ttl      = 0
  cache_behavior_max_ttl          = 0
}

module "aws_s3bucket_app" {
  source            = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket?ref=v0.9.0"
  s3_bucket         = "${local.safe_infrastructure_identifier}"
  allowed_iam_arns  = ["${module.aws_cf_oai.oai_arn}"]
  enable_versioning = true
  enable_destroy    = true
  bucket_canned_acl = "private"  
}

module "aws_cf_oai" {
  source  = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/origin-access-identity?ref=v0.9.0"
  comment = "${local.infrastructure_identifier} user for accessing s3 buckets"
}

module "aws_lambda_edge_behavior_default" {
  source                  = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/lambda/lambda_edge?ref=v0.9.0"
  lambda_function_name    = "${local.safe_infrastructure_identifier}"
  lambda_role_name        = "${local.safe_infrastructure_identifier}"
  lambda_function_handler = "redirect-rules"  # filename without extension
  filename                = "${local.lambda_filename}"
  publish                 = true

  providers = {
    aws = "aws.us-east-1" # lambda@edge must be created in us-east-1 region
  }
}
