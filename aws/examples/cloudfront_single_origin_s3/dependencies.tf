locals {
  infrastructure_identifier      = "DFDS Example app"
  safe_infrastructure_identifier = replace(lower(local.infrastructure_identifier), " ", "-")
}
