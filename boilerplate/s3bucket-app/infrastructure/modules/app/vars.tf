variable "env" {
  description = "Environment name will be used to prefix/postfix Terraform resources"
}

variable "cf_dist_logging_enable" {
  default = false
}

variable "cf_dist_wait_for_deployment" {
  default = true
  description = "If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process and finish applying without waiting."
}
