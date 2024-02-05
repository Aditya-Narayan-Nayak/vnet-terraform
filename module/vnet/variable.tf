variable "vnet_name" {
  description = "The name of the virtual network"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
}

variable "subnet_configs" {
  description = "List of subnet configurations for the virtual network"
  type        = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "location" {
  description = "The Azure region where the resources will be created"
}

variable "resource_group_name" {
  description = "The name of the Azure resource group"
}
