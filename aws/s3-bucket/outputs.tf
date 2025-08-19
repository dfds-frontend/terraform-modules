output "bucket_domain_name" {
  value = element(concat(aws_s3_bucket.bucket[0].bucket_regional_domain_name, list("")), 0)
}

output "bucket_name" {
  value = element(concat(aws_s3_bucket.bucket[0].id, list("")), 0)
}

output "bucket_arn" {
  value = element(concat(aws_s3_bucket.bucket[0].arn, list("")), 0)
}
