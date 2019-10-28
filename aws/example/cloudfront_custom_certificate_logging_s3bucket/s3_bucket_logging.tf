module "aws_s3_bucket_cloudfront_logging" {
  //source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  region = "${local.region}"
  source = "./../../s3-bucket/"
  s3_bucket = "logging-bucket-${local.safe_infrastructure_identifier}"
  enable_versioning = false
  enable_destroy = false
  enable_retention_policy = true
  retention_days = 90
  bucket_canned_acl = "log-delivery-write"
}