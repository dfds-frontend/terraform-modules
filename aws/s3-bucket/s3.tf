terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}

  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "~> 0.12.2"
}

resource "aws_s3_bucket" "bucket" {
  count = "${var.deploy ? 1:0 }"
  bucket = var.s3_bucket
  acl    = var.bucket_canned_acl

  tags = {
    "Managed by" = "Terraform"
  }

  versioning {
    enabled = var.enable_versioning
  }

  force_destroy = var.enable_destroy

  dynamic "lifecycle_rule" {    
    for_each = "${var.enable_retention_policy ? [1] : [] }"
    content {
      enabled = true
      prefix = "${var.lifecycle_rule_files_prefix}"

      id = "content_retention_policy"    
      abort_incomplete_multipart_upload_days = "${var.retention_days}"

      expiration {
        days = "${var.retention_days}"
      }

      noncurrent_version_expiration {
        days = "${var.retention_days}"
      }     
    }
  }
}