variable function_name {
    type = string
}

variable principal {
    type = string
}

variable source_arn {
    type = string
}

variable "qualifier" {
    type = string
    description = "(optional) describe your variable"
}

variable "lambda_name" {
    type = string
    description = "(optional) describe your variable"    
}
variable "lambda_version" {
    type = string
    description = "(optional) describe your variable"
}