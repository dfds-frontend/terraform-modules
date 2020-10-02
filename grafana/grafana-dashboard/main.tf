terraform {
  required_version = "~> 0.12.2"
}

locals {
  override_values_map = merge(var.additional_override_values, dashboard_title = var.title)
  dashboard_json = templatefile(var.input_file, local.override_values_map )
  dashboard_info_file = "dashboard_${timestamp()}.txt"
}

resource "grafana_dashboard" "dashboard" {
  folder = var.folder_id
  config_json = local.dashboard_json
}

resource "null_resource" "get-dashobard-id" {
  triggers = {
      always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "echo $(curl --location --request GET \"$GRAFANA_URL/api/search?folderIds=$FOLDER_ID&query=$DASHBOARD_TITLE\" --header \"Authorization: Bearer $GRAFANA_AUTH\" | jq .[].id -r) > $DASHBOARD_INFO_FILE"
    environment = {
      FOLDER_ID = var.folder_id
      DASHBOARD_TITLE = var.title
      DASHBOARD_INFO_FILE = local.dashboard_info_file
    }
  }
  depends_on = ["grafana_dashboard.dashboard"]
}

data "local_file" "input" {
  filename = "${path.module}/${local.dashboard_info_file}"
  depends_on = ["null_resource.get-dashobard-id"]
}