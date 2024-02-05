provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "my-resources"
  location = "Singapore"
}

# VNET 1
resource "azurerm_virtual_network" "my_project_vnet1" {
  name                = "my-project-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.2.0/20"]
}

# Subnets for VNET 1
resource "azurerm_subnet" "my_public_subnet1" {
  name                 = "my-public-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_project_vnet1.name
  address_prefixes     = ["10.1.2.0/25"]
}

resource "azurerm_subnet" "my_public_subnet2" {
  name                 = "my-public-subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_project_vnet1.name
  address_prefixes     = ["10.1.2.128/25"]
}

# VNET 2
resource "azurerm_virtual_network" "my_project_vnet2" {
  name                = "my-project-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.2.0.0/20"]
}

# Subnet for VNET 2
resource "azurerm_subnet" "my_public_subnet2a" {
  name                 = "my-public-subnet2a"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_project_vnet2.name
  address_prefixes     = ["10.2.0.0/24"]
}

# VNET Peering from VNET 1 to VNET 2
resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name                 = "vnet1-to-vnet2-peering"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_project_vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.my_project_vnet2.id
}

# VNET Peering from VNET 2 to VNET 1
resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name                 = "vnet2-to-vnet1-peering"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_project_vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.my_project_vnet1.id
}

# Network Security Group (NSG) for Subnet-1
resource "azurerm_network_security_group" "nsg_subnet1" {
  name                = "nsg-subnet1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# NSG Rule to allow SSH from Subnet-2a
resource "azurerm_network_security_rule" "allow_ssh_from_subnet2a" {
  name                        = "SSHFromSubnet2a"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "10.2.0.0/24"
  destination_address_prefix  = "10.1.2.0/25"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg_subnet1.name
}

# Associate NSG to Subnet-1
resource "azurerm_subnet_network_security_group_association" "subnet1_nsg_association" {
  subnet_id                 = azurerm_subnet.my_public_subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg_subnet1.id
}