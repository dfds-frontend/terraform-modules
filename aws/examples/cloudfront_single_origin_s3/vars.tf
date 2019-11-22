variable "cf_dist_logging_enable" {
  default = false
}

variable "cf_dist_wait_for_deployment" {
  default = true
  description = "If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process and finish applying without waiting."
}

variable "region" {
  description = "Specify the region in which AWS resources will be created."
}
