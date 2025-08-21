output "distribution_domain_name" {
  value = module.aws_cf_dist_s3.distribution_domain_name
}

output "distribution_hosted_zone_id" {
  value = module.aws_cf_dist_s3.distribution_hosted_zone_id
}
