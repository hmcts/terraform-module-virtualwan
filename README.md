# terraform-module-virtualwan

A Terraform module for creating Azure VirtualWAN and associated resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.41.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.41.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit.express_route_circuit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit) | resource |
| [azurerm_express_route_circuit_authorization.express_route_circuit_authorization](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_authorization) | resource |
| [azurerm_express_route_circuit_peering.express_route_circuit_peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_peering) | resource |
| [azurerm_express_route_connection.express_route_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_connection) | resource |
| [azurerm_express_route_gateway.express_route_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_gateway) | resource |
| [azurerm_resource_group.virtual_wan_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_hub.virtual_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub) | resource |
| [azurerm_virtual_hub_connection.virtual_hub_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_connection) | resource |
| [azurerm_virtual_hub_route_table.virtual_hub_route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_route_table) | resource |
| [azurerm_virtual_hub_route_table_route.virtual_hub_route_table_route](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_route_table_route) | resource |
| [azurerm_virtual_network_gateway.virtual_network_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.virtual_network_gateway_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |
| [azurerm_virtual_wan.virtual_wan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_wan) | resource |
| [azurerm_vpn_gateway.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway) | resource |
| [azurerm_vpn_gateway_connection.vpn_gateway_connections](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway_connection) | resource |
| [azurerm_vpn_site.vpn_site](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_site) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied to resources | `map(string)` | `{}` | no |
| <a name="input_express_route_circuit_authorizations"></a> [express\_route\_circuit\_authorizations](#input\_express\_route\_circuit\_authorizations) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_express_route_circuit_peerings"></a> [express\_route\_circuit\_peerings](#input\_express\_route\_circuit\_peerings) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_express_route_circuits"></a> [express\_route\_circuits](#input\_express\_route\_circuits) | Express Route Circuits | `map(map(any))` | `{}` | no |
| <a name="input_express_route_connections"></a> [express\_route\_connections](#input\_express\_route\_connections) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_express_route_gateways"></a> [express\_route\_gateways](#input\_express\_route\_gateways) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Target Azure location to deploy the resource. | `string` | `"UK South"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Enter Resource Group name. | `string` | `null` | no |
| <a name="input_virtual_hub_connection_propagated_route_tables"></a> [virtual\_hub\_connection\_propagated\_route\_tables](#input\_virtual\_hub\_connection\_propagated\_route\_tables) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_virtual_hub_connection_routing"></a> [virtual\_hub\_connection\_routing](#input\_virtual\_hub\_connection\_routing) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_virtual_hub_connection_static_vnet_routes"></a> [virtual\_hub\_connection\_static\_vnet\_routes](#input\_virtual\_hub\_connection\_static\_vnet\_routes) | n/a | `map(list(map(string)))` | `{}` | no |
| <a name="input_virtual_hub_connections"></a> [virtual\_hub\_connections](#input\_virtual\_hub\_connections) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_virtual_hub_route_table_routes"></a> [virtual\_hub\_route\_table\_routes](#input\_virtual\_hub\_route\_table\_routes) | n/a | <pre>map(object({<br/>    route_table_name  = string<br/>    destinations      = list(string)<br/>    destinations_type = optional(string, "CIDR")<br/>    next_hop          = string<br/>    next_hop_type     = optional(string, "ResourceId")<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_hub_route_tables"></a> [virtual\_hub\_route\_tables](#input\_virtual\_hub\_route\_tables) | n/a | <pre>map(object({<br/>    labels           = optional(string)<br/>    virtual_hub_name = string<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_hub_routes"></a> [virtual\_hub\_routes](#input\_virtual\_hub\_routes) | n/a | `map(list(map(string)))` | `{}` | no |
| <a name="input_virtual_hubs"></a> [virtual\_hubs](#input\_virtual\_hubs) | Virtual Hub | `map(map(any))` | `{}` | no |
| <a name="input_virtual_network_gateway_bgp_settings"></a> [virtual\_network\_gateway\_bgp\_settings](#input\_virtual\_network\_gateway\_bgp\_settings) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_virtual_network_gateway_connections"></a> [virtual\_network\_gateway\_connections](#input\_virtual\_network\_gateway\_connections) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_virtual_network_gateway_custom_routes"></a> [virtual\_network\_gateway\_custom\_routes](#input\_virtual\_network\_gateway\_custom\_routes) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_virtual_network_gateway_ip_configurations"></a> [virtual\_network\_gateway\_ip\_configurations](#input\_virtual\_network\_gateway\_ip\_configurations) | n/a | `map(list(map(string)))` | `{}` | no |
| <a name="input_virtual_network_gateway_peering_addresses"></a> [virtual\_network\_gateway\_peering\_addresses](#input\_virtual\_network\_gateway\_peering\_addresses) | n/a | `map(list(map(string)))` | `{}` | no |
| <a name="input_virtual_network_gateway_revoked_certificates"></a> [virtual\_network\_gateway\_revoked\_certificates](#input\_virtual\_network\_gateway\_revoked\_certificates) | n/a | `map(list(map(string)))` | `{}` | no |
| <a name="input_virtual_network_gateway_root_certificates"></a> [virtual\_network\_gateway\_root\_certificates](#input\_virtual\_network\_gateway\_root\_certificates) | n/a | `map(list(map(string)))` | `{}` | no |
| <a name="input_virtual_network_gateway_vpn_client_configurations"></a> [virtual\_network\_gateway\_vpn\_client\_configurations](#input\_virtual\_network\_gateway\_vpn\_client\_configurations) | n/a | `map(map(any))` | `{}` | no |
| <a name="input_virtual_network_gateways"></a> [virtual\_network\_gateways](#input\_virtual\_network\_gateways) | Virtual Network Gateways | `map(map(any))` | `{}` | no |
| <a name="input_virtual_wans"></a> [virtual\_wans](#input\_virtual\_wans) | Virtual WAN | `map(map(any))` | n/a | yes |
| <a name="input_vpn_gateway_connections"></a> [vpn\_gateway\_connections](#input\_vpn\_gateway\_connections) | n/a | <pre>map(object({<br/>    vpn_gateway_id       = string<br/>    remote_vpn_site_name = string<br/>  }))</pre> | `{}` | no |
| <a name="input_vpn_gateway_connections_links"></a> [vpn\_gateway\_connections\_links](#input\_vpn\_gateway\_connections\_links) | n/a | <pre>map(list(object({<br/>    name                           = string<br/>    vpn_site_link_name             = optional(string, null)<br/>    bgp_enabled                    = optional(bool, true)<br/>    egress_nat_rule_ids            = optional(list(string), [])<br/>    ingress_nat_rule_ids           = optional(list(string), [])<br/>    protocol                       = optional(string, "IKEv2")<br/>    local_azure_ip_address_enabled = optional(bool, false)<br/>    route_weight                   = optional(number, 0)<br/>  })))</pre> | `{}` | no |
| <a name="input_vpn_gateways"></a> [vpn\_gateways](#input\_vpn\_gateways) | VPN Sites | <pre>map(object({<br/>    location            = optional(string)<br/>    resource_group_name = optional(string)<br/>    scale_unit          = optional(number, 1)<br/>    virtual_hub_name    = string<br/>  }))</pre> | `{}` | no |
| <a name="input_vpn_site_links"></a> [vpn\_site\_links](#input\_vpn\_site\_links) | n/a | <pre>map(list(object({<br/>    asn             = optional(string, null)<br/>    ip_address      = string<br/>    name            = string<br/>    peering_address = optional(string, null)<br/>    provider_name   = string<br/>    speed_in_mbps   = number<br/>    fqdn            = optional(string, null)<br/>  })))</pre> | `{}` | no |
| <a name="input_vpn_sites"></a> [vpn\_sites](#input\_vpn\_sites) | n/a | <pre>map(object({<br/>    address_cidrs       = optional(list(string), [])<br/>    device_model        = optional(string, null)<br/>    device_vendor       = optional(string, null)<br/>    location            = optional(string)<br/>    resource_group_name = optional(string)<br/>    virtual_wan_name    = string<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_virtual_hub_connection_ids"></a> [virtual\_hub\_connection\_ids](#output\_virtual\_hub\_connection\_ids) | n/a |
<!-- END_TF_DOCS -->