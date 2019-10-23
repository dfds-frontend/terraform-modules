output "certificate_arn" {
  value = "${element(concat(aws_acm_certificate_validation.main.*.certificate_arn, list("")), 0)}"
}