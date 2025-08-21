provider "aws" {
  region = "eu-central-1" # default
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}
