// Certificates must be located same regon as where they must be used, eg. cloudfront is currently only supported in region "us-east-1".
provider "aws" {
  version = "~> 2.27"
  region  = "${var.region}"
}