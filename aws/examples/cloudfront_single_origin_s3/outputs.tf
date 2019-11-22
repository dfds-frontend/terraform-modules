output "aws_cloudfront_distribution_domain_name" {
  value = "${module.aws_cloudfront.distribution_domain_name} (${local.safe_infrastructure_identifier})"
}