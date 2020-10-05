terraform {
  required_version = "~> 0.12.2"
}
  
resource "grafana_folder" "folder" {
  title = var.name
}