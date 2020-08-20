terraform {
  required_version = "~> 0.12.2"
}

resource "aws_s3_bucket" "bucket" {
  count = "${var.deploy ? 1:0 }"
  bucket = var.s3_bucket
  acl    = var.bucket_canned_acl

  tags = var.tags

  versioning {
    enabled = var.enable_versioning
  }

  force_destroy = var.enable_destroy

  dynamic "lifecycle_rule" { // TODO: Add possibility to apply different rules on different paths
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

resource "aws_s3_bucket_policy" "b" {
  count = "${var.deploy && length(var.allowed_iam_arns) > 0 ? 1:0 }"
  bucket = "${aws_s3_bucket.bucket[0].id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Sid": "1",
      "Effect": "Allow",
      "Principal": {
             "AWS": ${jsonencode(var.allowed_iam_arns)} 
           },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket[0].id}/*"
    }
  ]
}
POLICY
}