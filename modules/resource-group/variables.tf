variable "module_version" {
  type = string
  validation {
    condition = var.module_version == "1.0"
    error_message = "Module version mismatch. Please verify you are using the latest version"
  }
}

variable "resource_group" {
  type = string
  description = "Name of the resource group"
  default = null
}

variable "location" {
  type = string
  description = "Location of the resource group"
  default = null
}

variable "tags" {
  type = map(string)
}

