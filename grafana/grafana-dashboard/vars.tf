variable "folder_id" {
  
}

variable "input_file" {
  description = "File containing dashboard in json format"
  type = string
}


variable "dashboard_values" {
  description = "It depends on the variables defined in the dashboard input json. Recommended value map {dasboard_title = "", env = "" }"
  type        = map(string)
} 