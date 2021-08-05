resource "azurerm_virtual_network" "hub" {
    name = replace(replace(var.NAMING_CONVENTION, "{{KEY}}", var.HUB.name), "{{TYPE}}", var.VNET_TYPE)

    address_space       = var.HUB.address_space
    location            = azurerm_resource_group.hub.location
    resource_group_name = azurerm_resource_group.hub.name

    dns_servers = var.DNS_SERVERS

    tags = var.TAGS
}

resource "azurerm_subnet" "hub-subnets" {
    for_each = var.HUB.subnets

    name                 = each.key
    address_prefixes     = each.value.address_prefixes
    resource_group_name  = azurerm_resource_group.hub.name
    virtual_network_name = azurerm_virtual_network.hub.name

    enforce_private_link_endpoint_network_policies = each.value.private_link
}

resource "azurerm_virtual_network" "spokes" {
    for_each = var.SPOKES

    name = replace(replace(var.NAMING_CONVENTION, "{{KEY}}", each.key), "{{TYPE}}", var.VNET_TYPE)

    address_space       = each.value.address_space
    location            = azurerm_resource_group.spokes[each.key].location
    resource_group_name = azurerm_resource_group.spokes[each.key].name

    dns_servers = var.DNS_SERVERS

    tags = var.TAGS
}

locals {
    spoke_subnets = flatten([
        for spoke_key, subnets in var.SPOKES : [
            for subnet_key, subnet in subnets.subnets : {
                spoke_key            = spoke_key
                subnet_key           = subnet_key
                address_prefixes     = subnet.address_prefixes
                private_link         = subnet.private_link
                resource_group_name  = azurerm_resource_group.spokes[spoke_key].name
                virtual_network_name = azurerm_virtual_network.spokes[spoke_key].name
            }
        ]
    ])

    flattened_subnets = {
        for subnet in local.spoke_subnets : "${subnet.spoke_key}.${subnet.subnet_key}" => subnet
    }
}

resource "azurerm_subnet" "spoke-subnets" {
    for_each = local.flattened_subnets

    name                 = each.value.subnet_key
    address_prefixes     = each.value.address_prefixes
    resource_group_name  = each.value.resource_group_name
    virtual_network_name = each.value.virtual_network_name

    enforce_private_link_endpoint_network_policies = each.value.private_link
}

resource "azurerm_virtual_network_peering" "hub-to-spokes" {
    for_each = var.SPOKES

    name = "${azurerm_virtual_network.hub.name}_to_${azurerm_virtual_network.spokes[each.key].name}"

    resource_group_name       = azurerm_resource_group.hub.name
    virtual_network_name      = azurerm_virtual_network.hub.name
    remote_virtual_network_id = azurerm_virtual_network.spokes[each.key].id
    allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "spokes-to-hub" {
    for_each = var.SPOKES

    name = "${azurerm_virtual_network.spokes[each.key].name}_to_${azurerm_virtual_network.hub.name}"

    resource_group_name       = azurerm_resource_group.spokes[each.key].name
    virtual_network_name      = azurerm_virtual_network.spokes[each.key].name
    remote_virtual_network_id = azurerm_virtual_network.hub.id
    use_remote_gateways       = var.USE_REMOTE_GATEWAYS
}