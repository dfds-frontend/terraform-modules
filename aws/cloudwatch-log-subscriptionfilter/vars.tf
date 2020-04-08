variable "name" {
  
}

variable "role_arn" {
  
}

variable "log_group_name" {
  
}
variable "filter_pattern" {
  
}
variable "destination_arn" {
  
}

variable "distribution" {
  default = null
}

variable "log_group_arn" {
  description = "Create dependency on log group"
}
