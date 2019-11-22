output "aws_cloudfront_distribution_domain_name" {
  value = "${module.aws_cloudfront-app.distribution_domain_name} (${local.infrastructure_identifier})"
}