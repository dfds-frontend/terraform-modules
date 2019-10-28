resource "aws_route53_record" "record" {  
  zone_id = "${var.zone_id}"
  name    = "${var.record_name}"
  type    = "${var.record_type}"
  records = "${var.record_value}"
  # ttl     = "${var.record_ttl}"
  ttl = "${var.record_type == "CNAME" ? [var.record_ttl] : null}"
  dynamic "alias" {
    for_each = "${var.record_type == "A" ? [1] : [] }"
    content {
      name                   = "${var.alias_target_dns_name}"
      zone_id                = "${var.alias_target_zone_id}"
      evaluate_target_health = false
    }
  }
}