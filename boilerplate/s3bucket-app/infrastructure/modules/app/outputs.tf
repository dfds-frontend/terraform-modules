output "aws_cloudfront_distribution_domain_name" {
  value = "${module.aws_cloudfront_app.distribution_domain_name} (${local.infrastructure_identifier})"
}

output "aws_lambda_edge_latest_published_version" {
  value = "${module.aws_lambda_edge_behavior_default.lambda_function_latest_published_version} (${local.infrastructure_identifier})"
}

output "aws_s3bucket" {
  value = "${module.aws_s3bucket_app.bucket_name} (${local.infrastructure_identifier})"
}