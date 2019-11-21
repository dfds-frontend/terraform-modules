module "certificate_using_module" {
  //source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/acm-certificate-type-split/import-certificate" // To be used with tagging as well, this line is to serve as example for how this should be referenced in real world scenarios. The example here always refers to current local copy, hence the source definition below.
  region = "${local.region}"
  source = "./../../acm-certificate-import-certificate/"
  private_key = "${file("${path.module}/certificate-private-key.pem")}" //var.private_key maybe use: file("${path.module}/hello.txt")
  certificate_body = "${file("${path.module}/certificate-body.pem")}"
  certificate_chain = "${file("${path.module}/certificate-chain.pem")}"
  tag_name = "${local.safe_infrastructure_identifier}"
}