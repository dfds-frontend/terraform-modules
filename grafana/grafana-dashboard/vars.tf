# variable "title" {
#     description = "Dashboard title. Should unique within a folder"
#     type = string
# }

variable "folder_id" {
  default = null
}

variable "input_file" {
  description = "File containing dashboard in json format"
  type = string
}

# variable "additional_override_values" {
#     type = map(string)
# }