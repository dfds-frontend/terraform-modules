terraform {
  required_version = "~> 0.12.2"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${var.comment}"
}
