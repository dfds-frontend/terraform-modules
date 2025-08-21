output "bucket_domain_name" {
  value = aws_s3_bucket.bucket[0].bucket_regional_domain_name
}

output "bucket_name" {
  value = aws_s3_bucket.bucket[0].id
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket[0].arn
}
