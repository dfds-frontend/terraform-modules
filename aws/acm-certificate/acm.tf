locals {
  domain_names = "${concat([var.domain_name], var.subject_alternative_names)}"
}

# Create the certificate request
resource "aws_acm_certificate" "cert" {
  domain_name = "${local.domain_names[0]}"
  subject_alternative_names = "${slice(local.domain_names, 1, length(local.domain_names))}"
  validation_method = "${var.validation_method}"
  lifecycle {
    create_before_destroy = true
    ignore_changes = ["subject_alternative_names"] # workaround to https://github.com/terraform-providers/terraform-provider-aws/issues/8531
  }
}

# Create validation DNS record(s) in the specified DNS zone (alternative names specified)
resource "aws_route53_record" "cert_dns_validation" {
  count   = "${var.validation_method == "DNS" ? length(local.domain_names) : 0}"
  name = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_name")}"
  type = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_type")}"
  zone_id ="${var.dns_zone_id}"
  records = ["${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_value")}"]
  ttl = 60
}

# Validate the certificate using the DNS validation records created
resource "aws_acm_certificate_validation" "cert_dns_validation" {
  count   = "${var.validation_method == "DNS" ? 1 : 0}"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = "${aws_route53_record.cert_dns_validation.*.fqdn}"
}


resource "aws_acm_certificate_validation" "cert_email_validation" {
  count   = "${var.validation_method == "EMAIL" ? 1 : 0}"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
}