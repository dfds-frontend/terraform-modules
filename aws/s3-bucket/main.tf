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

  dynamic "lifecycle_rule" { 
    for_each = var.retention_settings
    iterator = it
    content {
      enabled = true
      prefix = it.value.files_prefix
      abort_incomplete_multipart_upload_days = it.value.retention_days

      expiration {
        days = it.value.retention_days
      }

      noncurrent_version_expiration {
        days = it.value.retention_days
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