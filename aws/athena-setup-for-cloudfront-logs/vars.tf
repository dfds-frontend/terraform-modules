variable "athena_workgroup_name" {
  type = string
}

variable "athena_output_location" {
  type = string
}

variable "bucket_query_results" {
  type = string
}

variable "source_bucket_path" {
  type = string
}

variable "athena_db_name" {
  type        = string
  description = "Athena Database name"
}

variable "athena_table_name" {
  type        = string
  description = "Default table name"
}