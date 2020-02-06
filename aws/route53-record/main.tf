terraform {
  required_version = "~> 0.12.2"
}

resource "aws_route53_record" "alias_record" {  
  count   = "${var.create_record && var.record_type == "A" ? 1 : 0}"
  zone_id = "${var.zone_id}"
  name    = "${var.record_name}"
  type    = "${var.record_type}"
  alias {
    name                   = "${var.alias_target_dns_name}"
    zone_id                = "${var.alias_target_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cname_record" {
  count   = "${var.create_record && var.record_type == "CNAME" ? 1 : 0}"
  zone_id = "${var.zone_id}"
  name    = "${var.record_name}"
  type    = "${var.record_type}"
  ttl     = "${var.record_ttl}"
  records = ["${var.record_value}"]
}
