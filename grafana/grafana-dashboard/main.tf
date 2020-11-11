terraform {
  required_version = "~> 0.12.2"
}

resource "grafana_dashboard" "dashboard" {
  folder = var.folder_id
  config_json = file(var.input_file)
}