/*provider "aws" {
  region  = "us-east-1"
  version = "~> 2.27.0"
  alias = "us-east-1"
}*/

provider "aws" {
  version = "~> 2.27"
  region  = "${var.region}"
}