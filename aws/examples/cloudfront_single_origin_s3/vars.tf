variable "cf_dist_logging_enable" {
  description = "Whether to enable logging for the CloudFront distribution."
  type        = bool
  default     = false
}

variable "cf_dist_wait_for_deployment" {
  description = "Whether to wait for the CloudFront distribution to be deployed."
  type        = bool
  default     = true
}

variable "region" {
  description = "Specify the region in which AWS resources will be created."
  type        = string
}
