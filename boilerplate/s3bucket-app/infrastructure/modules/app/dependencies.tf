locals {
  app_name = "my-application"
  app_path = "my-business-unit/my-application"
  infrastructure_identifier = "${local.app_name}${var.env == "prod"? "" : " ${upper(var.env)}"}"
  safe_infrastructure_identifier = "${replace(lower(local.infrastructure_identifier), " ", "-")}"  
  lambda_filename = "redirect-rules.js"
}