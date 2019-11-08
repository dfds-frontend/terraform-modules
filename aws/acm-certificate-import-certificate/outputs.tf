//Need to be exposed when certificates are needed in other infastructure setups, in applications
output "imported-certificate-arn" {
  //output arn should be used eg in the cloudfront prop: acm_certificate_arn
  value = aws_acm_certificate.import_certificate.arn
}

output "imported-certificate-domain_name" {
  value = aws_acm_certificate.import_certificate.domain_name
}



