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

variable "nsg" {
  description = "Name of the nsg"
  default = null
}
variable "nsg_rules" {
  description = "Name of the nsg rules"
  default = null
}

variable "subnet_id" {
  type = string
  description = "subnet ID"
  default = null
}

variable "location" {
  type = string
  description = "Location of the resource group"
  default = null
}

variable "network_security_group_id" {
  type = string
  description = "network_security_group_id"
  default = null
}

variable "tags" {
  type = map(string)
}



