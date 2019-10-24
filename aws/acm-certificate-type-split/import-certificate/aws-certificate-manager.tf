resource "aws_acm_certificate" "import_certificate" {
//  lifecycle {
//    create_before_destroy = true
//  }

  private_key       = "${var.private_key}"
  certificate_body  = "${var.certificate_body}"
  certificate_chain = "${var.certificate_chain}"

  tags = {
    Name            = "${var.tag_name}"
  }
}