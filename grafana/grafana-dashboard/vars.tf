variable "folder_id" {
  
}

variable "input_file" {
  description = "File containing dashboard in json format"
  type = string
}


variable "dashboard_values" {
  description =
  <<DESCRIPTION
   "It depends on the variables defined in the dashboard input json. Recommended value map {"dasboard_title" = "some_title", "env" = "some_environment" }
  DESCRIPTION
  type        = map(string)
} 