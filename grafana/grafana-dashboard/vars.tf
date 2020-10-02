variable "title" {
    description = "Dashboard title. Should unique within a folder"
    type = string
}


variable "folder_id" {
  
}

variable "input_file" {
  description = "File containing dashboard in json format"
  type = string
}

variable "additional_override_values" {
    type = map(string)
}

# variable "dashboard_values" {
#   # description = <<TEXT  
#   #  It depends on the variables defined in the dashboard input json. Recommended value map {"dasboard_title" = "some_title", "env" = "some_environment"}
#   # TEXT
#   type        = map(string)
# } 