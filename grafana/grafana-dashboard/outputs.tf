output "dashboard_title" {
  value = local.dashboard_title
}

output "grafana_dashboard_id" {
  value = chomp(data.local_file.input.content)
}