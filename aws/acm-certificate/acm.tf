locals {
  domain_names = "${concat([var.domain_name], var.subject_alternative_names)}"
}

# Create the certificate request
resource "aws_acm_certificate" "cert" {
  domain_name = "${local.domain_names[0]}"
  subject_alternative_names = "${slice(local.domain_names, 1, length(local.domain_names))}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
    ignore_changes = ["subject_alternative_names"] # workaround to https://github.com/terraform-providers/terraform-provider-aws/issues/8531
  }
}

# Create validation DNS record(s) in the specified DNS zone (alternative names specified)
resource "aws_route53_record" "validation" {
  count = "${var.validation_method == "DNS" ? length(local.domain_names) : 0}"
  name = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_name")}"
  type = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_type")}"
  zone_id ="${var.dns_zone_id}"
  records = ["${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_value")}"]
  ttl = 60
}

# Validate the certificate using the DNS validation records created
# This resource represents a successful validation of an ACM certificate in concert with other resources.
# WARNING: This resource implements a part of the validation workflow. It does not represent a real-world entity in AWS, therefore changing or deleting this resource on its own has no immediate effect.
resource "aws_acm_certificate_validation" "cert" {
  count = "${var.validation_method == "DNS" && var.wait_for_validation ? 1 : 0 }"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = "${aws_route53_record.validation.*.fqdn}"
}