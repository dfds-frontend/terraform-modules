variable "domain_name" {}


variable "subject_alternative_names" {
  type = "list"
  default = []  
}

variable "dns_zone_id" {
  
}

variable "validation_method" {
  type = "string"
  description = "Allows values: DNS, EMAIL and NONE"
}
