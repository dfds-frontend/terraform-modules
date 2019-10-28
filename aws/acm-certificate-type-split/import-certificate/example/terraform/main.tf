// Combining certificate import with creation of an self signed cert (using tls provider), to demonstrate import functionality.
// region is here defaulted to eu-central-1, as defined in module folder (DFDS default region)
module "certificate_using_module" {
  source = "./../../"
  private_key = "${module.selfsigned_certificate.certificate_private_key_pem}"
  certificate_body = "${module.selfsigned_certificate.certificate_body_pem}"
  tag_name = "terragrunt_example_cert"
}

module "selfsigned_certificate" {
    source = "./../self_signed_example_cert/"  
}

output "imported-certificate-arn" {
  //output arn should be used eg in the cloudfront prop: acm_certificate_arn
  value = module.certificate_using_module.imported-certificate-arn
}