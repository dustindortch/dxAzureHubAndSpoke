variable "LOCATION" {
    type        = string
    description = "Azure region for deployment."
}

variable "DNS_SERVERS" {
    type        = list(string)
    description = "DNS servers for Azure virtual networks."

    default = []
}

variable "NAMING_CONVENTION" {
    type = string
    default = "prefix{{KEY}}{{TYPE}}"
    description = "Naming convention format"

    validation {
        condition = can(regex("^.*({{KEY}}).*$", var.NAMING_CONVENTION)) && can(regex("^.*({{TYPE}}).*$", var.NAMING_CONVENTION))
        error_message = "The naming convention must contain a {{KEY}} and {{TYPE}} component."
    }
}

variable "RG_TYPE" {
    type        = string
    description = "Naming convention representation for a resource group."

    default = "rg"
}

variable "VNET_TYPE" {
    type        = string
    description = "Naming convention representation for a virtual network."

    default = "vnet"
}

variable "RT_TYPE" {
    type        = string
    description = "Naming convention representation for a route table."

    default = "rt"
}

variable "HUB" {
    type = object({
        name          = string
        address_space = list(string)
        subnets      = map(object({
            address_prefixes = list(string)
            private_link     = bool
        }))
    })

    description = "Representation of the network hub."
}

variable "SPOKES" {
    type = map(object({
        address_space = list(string)
        subnets       = map(object({
            address_prefixes = list(string)
            private_link     = bool
        }))
    }))

    description = "Representation of the network spokes."
}

variable "USE_REMOTE_GATEWAYS" {
    type        = bool
    description = "Use for routing from spokes through hub."

    default = false
}

variable "TAGS" {
    type        = object({})
    description = "Tags to assign to managed resources."

    default = {
        CreatedBy = "Terraform"
        TFModule  = "Hub-and-Spoke"
    }
}