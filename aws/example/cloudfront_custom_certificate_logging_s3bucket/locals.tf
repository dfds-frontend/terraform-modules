locals {
    region = "us-east-1" // Region must be same for the certificate as for cloudfront, s3 bucket used for logging, should be located at same region as well, but it is not required. 
    infrastructure_identifier = "${var.prefix} Cloudfront by DFDS"
    safe_infrastructure_identifier = "${replace(lower(local.infrastructure_identifier), " ", "-")}"
}