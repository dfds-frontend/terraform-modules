output "folder_internal_id" {
  description = "The id is used by the grafana_dashboard resource to place a dashboard within a folder"
  value       = grafana_folder.folder.id
}

output "folder_internal_externa_id" { 
  description = "An external id of the folder in Grafana (stable when folders are migrated between Grafana instances"
  value = grafana_folder.folder.uid
}