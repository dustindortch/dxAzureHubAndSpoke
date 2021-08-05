# dxAzureHubAndSpoke

![Azure Hub and Spoke Architecture](docs/Architecture.png "Azure Hub and Spoke Architecture")

Hub and spoke architecture deployment within Azure for resource groups, virtual networks, subnets, and route table.  Include in deployment and add virtual appliances, routes, and security controls, as required.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.spokes](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.hub-subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.spoke-subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.spokes](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.hub-to-spokes](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.spokes-to-hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_DNS_SERVERS"></a> [DNS\_SERVERS](#input\_DNS\_SERVERS) | DNS servers for Azure virtual networks. | `list(string)` | `[]` | no |
| <a name="input_HUB"></a> [HUB](#input\_HUB) | Representation of the network hub. | <pre>object({<br>        name          = string<br>        address_space = list(string)<br>        subnets      = map(object({<br>            address_prefixes = list(string)<br>            private_link     = bool<br>        }))<br>    })</pre> | n/a | yes |
| <a name="input_LOCATION"></a> [LOCATION](#input\_LOCATION) | Azure region for deployment. | `string` | n/a | yes |
| <a name="input_NAMING_CONVENTION"></a> [NAMING\_CONVENTION](#input\_NAMING\_CONVENTION) | Naming convention format | `string` | `"prefix{{KEY}}{{TYPE}}"` | no |
| <a name="input_RG_TYPE"></a> [RG\_TYPE](#input\_RG\_TYPE) | Naming convention representation for a resource group. | `string` | `"rg"` | no |
| <a name="input_RT_TYPE"></a> [RT\_TYPE](#input\_RT\_TYPE) | Naming convention representation for a route table. | `string` | `"rt"` | no |
| <a name="input_SPOKES"></a> [SPOKES](#input\_SPOKES) | Representation of the network spokes. | <pre>map(object({<br>        address_space = list(string)<br>        subnets       = map(object({<br>            address_prefixes = list(string)<br>            private_link     = bool<br>        }))<br>    }))</pre> | n/a | yes |
| <a name="input_TAGS"></a> [TAGS](#input\_TAGS) | Tags to assign to managed resources. | `object({})` | <pre>{<br>  "CreatedBy": "Terraform",<br>  "TFModule": "Hub-and-Spoke"<br>}</pre> | no |
| <a name="input_USE_REMOTE_GATEWAYS"></a> [USE\_REMOTE\_GATEWAYS](#input\_USE\_REMOTE\_GATEWAYS) | Use for routing from spokes through hub. | `bool` | `false` | no |
| <a name="input_VNET_TYPE"></a> [VNET\_TYPE](#input\_VNET\_TYPE) | Naming convention representation for a virtual network. | `string` | `"vnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_HUB_RG"></a> [HUB\_RG](#output\_HUB\_RG) | Managed hub resource group. |
| <a name="output_HUB_SUBNETS"></a> [HUB\_SUBNETS](#output\_HUB\_SUBNETS) | Managed hub subnets. |
| <a name="output_HUB_VNET"></a> [HUB\_VNET](#output\_HUB\_VNET) | Managed hub virtual network. |
| <a name="output_RT"></a> [RT](#output\_RT) | Managed routing table. |
| <a name="output_SPOKES_RG"></a> [SPOKES\_RG](#output\_SPOKES\_RG) | Managed spokes resource groups. |
| <a name="output_SPOKES_SUBNETS"></a> [SPOKES\_SUBNETS](#output\_SPOKES\_SUBNETS) | Managed spokes subnets. |
| <a name="output_SPOKES_VNET"></a> [SPOKES\_VNET](#output\_SPOKES\_VNET) | Managed spokes virtual networks. |
<!-- END_TF_DOCS -->