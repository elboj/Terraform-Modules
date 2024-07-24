terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.88.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features{}
}

#Check if resource group already exists
# data "azurerm_resource_group" "resource_group" {
#   name = var.exist_resource_group
#   count = var.resource_group != "" ? 1 : 0
# }

#Create a new resource group
resource "azurerm_resource_group" "resource_group" {
  name = var.resource_group
  location = var.location
  tags = var.tags
}

output "name" {
  value = azurerm_resource_group.resource_group.location
}

#using dynamic and for each. Can I create multiple resource groups in
#different locations?