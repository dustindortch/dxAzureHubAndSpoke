resource "azurerm_route_table" "rt" {
    name = replace(replace(var.NAMING_CONVENTION, "{{KEY}}", var.HUB.name), "{{TYPE}}", var.RT_TYPE)

    location            = azurerm_resource_group.hub.location
    resource_group_name = azurerm_resource_group.hub.name
    tags               = var.TAGS
}