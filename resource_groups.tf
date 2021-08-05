resource "azurerm_resource_group" "hub" {
    name     = replace(replace(var.NAMING_CONVENTION, "{{KEY}}", var.HUB.name), "{{TYPE}}", var.RG_TYPE)

    location = var.LOCATION

    tags = var.TAGS
}

resource "azurerm_resource_group" "spokes" {
    for_each = var.SPOKES

    name     = replace(replace(var.NAMING_CONVENTION, "{{KEY}}", each.key), "{{TYPE}}", var.RG_TYPE)
    location = var.LOCATION

    tags = var.TAGS
}