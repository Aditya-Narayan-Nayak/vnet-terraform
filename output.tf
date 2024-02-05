# Output for Resource Group
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

# Outputs for VNET 1
output "vnet1_name" {
  value = azurerm_virtual_network.my_project_vnet1.name
}

output "vnet1_id" {
  value = azurerm_virtual_network.my_project_vnet1.id
}

# Outputs for Subnets in VNET 1
output "subnet1_name" {
  value = azurerm_subnet.my_public_subnet1.name
}

output "subnet1_id" {
  value = azurerm_subnet.my_public_subnet1.id
}

output "subnet2_name" {
  value = azurerm_subnet.my_public_subnet2.name
}

output "subnet2_id" {
  value = azurerm_subnet.my_public_subnet2.id
}

# Outputs for VNET 2
output "vnet2_name" {
  value = azurerm_virtual_network.my_project_vnet2.name
}

output "vnet2_id" {
  value = azurerm_virtual_network.my_project_vnet2.id
}

# Output for Subnet in VNET 2
output "subnet2a_name" {
  value = azurerm_subnet.my_public_subnet2a.name
}

output "subnet2a_id" {
  value = azurerm_subnet.my_public_subnet2a.id
}

# Outputs for VNET Peering
output "vnet1_to_vnet2_peering_id" {
  value = azurerm_virtual_network_peering.vnet1_to_vnet2.id
}

output "vnet2_to_vnet1_peering_id" {
  value = azurerm_virtual_network_peering.vnet2_to_vnet1.id
}

# Outputs for Network Security Group
output "nsg_subnet1_name" {
  value = azurerm_network_security_group.nsg_subnet1.name
}

output "nsg_subnet1_id" {
  value = azurerm_network_security_group.nsg_subnet1.id
}
