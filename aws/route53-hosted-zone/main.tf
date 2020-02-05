terraform {
  required_version = "~> 0.12.2"
}
resource "aws_route53_zone" "dnszone" {
  # This will create a route 53 DNS zone with the hostname provided
  name = "${var.dns_zone_name}"

  tags = var.tags
}