variable "zone_id" {}

variable "record_name" {
  type    = "string"
}
variable "record_type" {}

variable "alias_target_dns_name" {
  default = ""
}

variable "alias_target_zone_id" {
  default = ""
}

variable "record_ttl" {
  default = "300"
}

variable "record_value" {
  type = "list"
}
