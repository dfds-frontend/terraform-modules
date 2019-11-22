locals {
  infrastructure_identifier = "${var.app_name}${var.env == "prod"? "" : " ${upper(var.env)}"}"
  safe_infrastructure_identifier = "${replace(lower(local.infrastructure_identifier), " ", "-")}"  
}