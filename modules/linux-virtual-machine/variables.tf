variable "module_version" {
  type = string
  validation {
    condition = var.module_version == "0.1.1"
    error_message = "Module version mismatch. Verify you are using latest version"
  }
}

variable "resource_group_name" {
  description = "RG name"
  default = "rg-uks-gen-dev001"
}

variable "location" {
  description = "RG location"
  default = "UK South"
}

variable "virtual_network_name" {
  description = "virtual_network_name"
  # default = "vnt-uks-gen-dev001"
}

variable "subnet_name" {
  description = "subnet_name"
  # default = "default"
}

variable "nic_name" {
  description = "nic_name"
  # default = "nic-uks-vm-dev001"
}

variable "ip_config" {
  description = "ip_config"
  # default = "ip_config"
}

variable "domain_name_label" {
  description = "domain_name_label"
  # default = "ip_config"
}

variable "vm_public_ip" {
  description = "vm_public_ip"
  # default = "pip-uks-gen-dev001"
}

variable "vm_name" {
  description = "vm_name"
  # default = "vm-uks-gen-dev001"
}

variable "vm_size" {
  description = "vm_size"
  # default = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "admin_username"
  # default = "elboj_admin"
}

variable "admin_password" {
  description = "admin_password"
  # default = "__VM_PASSWORD__"
}

variable "storage_account_type"{
  description = "storage_account_type"
  # default = "storage_account_type"
}

variable "disk_size_gb"{
  description = "disk_size_gb"
  # default = "disk_size_gb"
}

variable "managed_disk_name" {
  description = "managed_disk_name"
  # default = "managed_disk_name"
}
