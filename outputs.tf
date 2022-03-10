### Virtual Network ###


#begin subnets#
output "vnet_subnet_public" {
  value = azurerm_subnet.public.address_prefix
}

output "vnet_subnet_private" {
  value = azurerm_subnet.private.address_prefix
}

output "subnet_id" {
  value = azurerm_virtual_network.vnet.subnet.id
}
#end subnets#

output "vnet_guid" {
  value = azurerm_virtual_network.vnet.guid
}

output "vnet_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "vnet_location" {
  value = azurerm_virtual_network.vnet.location
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_resource_group" {
  value = azurerm_virtual_network.vnet.resource_group_name
}
