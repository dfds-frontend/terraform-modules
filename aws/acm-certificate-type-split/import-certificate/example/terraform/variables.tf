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

//tag_name