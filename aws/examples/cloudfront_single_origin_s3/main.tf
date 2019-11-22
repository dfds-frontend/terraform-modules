terraform {
  backend "s3" {}
}

provider "aws" {
  region     = "${var.region}"
  version = "~> 2.28.1"
}

module "aws_cloudfront" {
  source                          = "./../../cloudfront/cloudfront_single_origin_s3"
  comment                         = "${local.infrastructure_identifier}"
  s3_bucket_domain_name           = "${module.aws_s3-app.bucket_domain_name}"
  origin_access_identity          = "${module.aws_cf_oai.origin_access_identity}"
  logging_enable                  = "${var.cf_dist_logging_enable}"
  logging_include_cookies         = false
  logging_bucket                  = "${module.aws_s3-app.bucket_domain_name}"
  logging_prefix                  = "cf_logs"
  wait_for_deployment             = "${var.cf_dist_wait_for_deployment}"
  custom_error_response_page_path = "/error.html"
  custom_error_response_code      = 404
  cache_behavior_min_ttl          = 0
  cache_behavior_default_ttl      = 0
  cache_behavior_max_ttl          = 0
}

module "aws_s3-app" {
  source            = "./../../s3-bucket"
  s3_bucket         = "${local.safe_infrastructure_identifier}"
  allowed_iam_arns  = ["${module.aws_cf_oai.oai_arn}"]
  enable_versioning = false
  enable_destroy    = true
  bucket_canned_acl = "private"
}

module "aws_cf_oai" {
  source  = "./../../origin-access-identity"
  comment = "${local.infrastructure_identifier} user for accessing s3 buckets"
}
