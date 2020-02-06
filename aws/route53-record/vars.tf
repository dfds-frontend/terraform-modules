variable "zone_id" {}

variable "record_name" {
  type    = "string"
}
variable "record_type" {
  type = "string"
}

variable "alias_target_dns_name" {
  type = "string"
  default = ""
}

variable "alias_target_zone_id" {
  type = "string"
  default = ""
}

variable "record_ttl" {  
  default = 300
}

variable "record_value" {
  type = "string"
}

variable "create_record" {
  type = bool
  default = true
}
