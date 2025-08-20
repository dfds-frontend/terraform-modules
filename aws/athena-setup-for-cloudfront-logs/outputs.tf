output "log_source_bucket_path" {
  value = var.source_bucket_path
}

output "athena_workgroup_name" {
  value = var.athena_output_location
}

output "athena_output_location" {
  value = var.athena_workgroup_name
}

output "bucket_query_results" {
  value = var.bucket_query_results
}

output "athena_db_name" {
  value = var.athena_db_name
}

output "athena_table_name" {
  value = var.athena_table_name
}