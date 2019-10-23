/*
resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "example" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.example.private_key_pem}"

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "cert" {
//  lifecycle {
//    create_before_destroy = true
//  }

  private_key       = "${tls_private_key.example.private_key_pem}"
  certificate_body  = "${tls_self_signed_cert.example.cert_pem}"
  certificate_chain = 
}
*/

//US-EAST-1.

resource "aws_acm_certificate" "import_certificate" {
//  lifecycle {
//    create_before_destroy = true
//  }

  private_key       = "${var.private_key}"
  certificate_body  = "${var.certificate_body}"
  certificate_chain = "${var.certificate_chain}"

  //tags = {
  //  Name            = "${var.tag_name}"
  //}
}