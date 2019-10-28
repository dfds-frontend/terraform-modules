module "certificate_using_module" {
  //source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/acm-certificate-type-split/import-certificate" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  region = "${local.region}"
  source = "./../../acm-certificate-type-split/import-certificate/"
  private_key = "${module.selfsigned_certificate.certificate_private_key_pem}" //var.private_key maybe use: file("${path.module}/hello.txt")
  certificate_body = "${module.selfsigned_certificate.certificate_body_pem}" //var.certificate_body
  tag_name = "${local.safe_infrastructure_identifier}"
}

module "selfsigned_certificate" {
    source = "./../../acm-certificate-type-split/import-certificate/example/self_signed_example_cert/"  
}