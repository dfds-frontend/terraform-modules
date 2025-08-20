terraform {
  required_version = ">= 0.13, < 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.7.1"
    }
  }
}
