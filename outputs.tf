output "HUB_RG" {
    value       = azurerm_resource_group.hub
    description = "Managed hub resource group."
}

output "HUB_VNET" {
    value       = azurerm_virtual_network.hub
    description = "Managed hub virtual network."
}

output "HUB_SUBNETS" {
    value       = azurerm_subnet.hub-subnets
    description = "Managed hub subnets."
}

output "SPOKES_RG" {
    value       = azurerm_resource_group.spokes
    description = "Managed spokes resource groups."
}

output "SPOKES_VNET" {
    value       = azurerm_virtual_network.spokes
    description = "Managed spokes virtual networks."
}

output "SPOKES_SUBNETS" {
    value       = azurerm_subnet.spoke-subnets
    description = "Managed spokes subnets."
}

output "RT" {
    value       = azurerm_route_table.rt
    description = "Managed routing table."
}