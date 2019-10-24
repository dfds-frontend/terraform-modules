output "certificate_private_key_pem" {
  description = "The pem format certificate private key"
  value = "${tls_private_key.example.private_key_pem}"
}

output "certificate_body_pem" {
  description = "The pem format certificate body"
  value = "${tls_self_signed_cert.example.cert_pem}"
}