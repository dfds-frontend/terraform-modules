variable "folder_id" {
  
}

variable "input_file" {
  description = "File containing dashboard in json format"
  type = string
}


variable "dashboard_values" {
  type        = map(string)
  default     = { }
} 