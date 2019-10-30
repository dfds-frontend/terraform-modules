output "distribution_domain_name" {
  value = "${aws_cloudfront_distribution.aws_cf_dist_s3.distribution_domain_name}"
}

output "distribution_hosted_zone_id" {
  value = "${aws_cloudfront_distribution.aws_cf_dist_s3.distribution_hosted_zone_id}"
}