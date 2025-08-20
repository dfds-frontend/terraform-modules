output "alias_record_name" {
  value = aws_route53_record.alias_record.*.name
}

output "cname_record_name" {
  value = aws_route53_record.cname_record.*.name
}
