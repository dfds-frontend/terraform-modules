variable region {
  description = "Target AWS region (used in provider section, not in resource def.), default region of choice in DFDS is eu-central-1."
  type        = string
  default     = "eu-central-1"
}

variable "private_key" {
  type = "string"
  description = "(Required) The certificate's PEM-formatted private key"
}

variable "certificate_body" {
  type = "string"
  description = "(Required) The certificate's PEM-formatted public key"
}

variable "certificate_chain" {
  type = "string"
  description = "(Optional) The certificate's PEM-formatted chain"
  default = ""
}

variable tag_name {
  description = "The tagged name"
  type        = string
}