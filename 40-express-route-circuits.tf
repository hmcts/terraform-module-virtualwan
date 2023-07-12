# ExpressRoute Circuit
resource "azurerm_express_route_circuit" "express_route_circuit" {
  for_each = var.express_route_circuits

  allow_classic_operations = lookup(each.value, "allow_classic_operations", false)
  bandwidth_in_mbps        = lookup(each.value, "bandwidth_in_mbps", 2000)
  location                 = lookup(each.value, "location", azurerm_resource_group.virtual_wan_resource_group[0].location)
  name                     = each.key
  peering_location         = lookup(each.value, "peering_location", "London")
  resource_group_name      = lookup(each.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name)
  service_provider_name    = lookup(each.value, "service_provider_name", "Equinix")
  sku {
    family = lookup(each.value, "sky_family", "MeteredData")
    tier   = lookup(each.value, "sku_tier", "Premium")
  }

  tags = var.common_tags
}

# ExpressRoute Circuit Authorizations
resource "azurerm_express_route_circuit_authorization" "express_route_circuit_authorization" {
  for_each = var.express_route_circuit_authorizations

  express_route_circuit_name = lookup(each.value, "express_route_circuit_name", null)
  name                       = each.key
  resource_group_name        = lookup(each.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name)
}

# ExpressRoute Circuit Peerings
resource "azurerm_express_route_circuit_peering" "express_route_circuit_peering" {
  for_each = var.express_route_circuit_peerings

  express_route_circuit_name    = lookup(each.value, "express_route_circuit_name", null)
  primary_peer_address_prefix   = lookup(each.value, "primary_peer_address_prefix", null)
  peering_type                  = lookup(each.value, "peering_type", null)
  peer_asn                      = lookup(each.value, "peer_asn", null)
  resource_group_name           = lookup(each.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name)
  route_filter_id               = lookup(each.value, "route_filter_id", null)
  secondary_peer_address_prefix = lookup(each.value, "secondary_peer_address_prefix", null)
  shared_key                    = lookup(each.value, "shared_key", null)
  vlan_id                       = lookup(each.value, "vlan_id", null)

  dynamic "microsoft_peering_config" {
    for_each = lookup(each.value, "advertised_public_prefixes", null) != null ? [1] : []
    content {
      advertised_public_prefixes = lookup(each.value, "advertised_public_prefixes", null) != null ? split(",", replace(lookup(each.value, "advertised_public_prefixes", null), " ", "")) : []
      customer_asn               = lookup(each.value, "customer_asn", null)
      routing_registry_name      = lookup(each.value, "routing_registry_name", null)
    }
  }
  dynamic "ipv6" {
    for_each = lookup(each.value, "ipv6_advertised_public_prefixes", null) != null ? [1] : []
    content {
      primary_peer_address_prefix   = lookup(each.value, "ipv6_primary_peer_address_prefix", null)
      secondary_peer_address_prefix = lookup(each.value, "ipv6_secondary_peer_address_prefix", null)
      route_filter_id               = lookup(each.value, "ipv6_route_filter_id", null)
      dynamic "microsoft_peering" {
        for_each = lookup(each.value, "ipv6_advertised_public_prefixes", null) != null ? [1] : []
        content {
          advertised_public_prefixes = lookup(each.value, "ipv6_advertised_public_prefixes", null) != null ? split(",", replace(lookup(each.value, "advertised_public_prefixes", null), " ", "")) : []
          customer_asn               = lookup(each.value, "ipv6_customer_asn", null)
          routing_registry_name      = lookup(each.value, "ipv6_routing_registry_name", null)
        }
      }
    }
  }
}


# ExpressRoute Gateways
resource "azurerm_express_route_gateway" "express_route_gateway" {
  for_each = var.express_route_gateways

  location            = lookup(each.value, "location", azurerm_resource_group.virtual_wan_resource_group[0].location)
  name                = each.key
  resource_group_name = lookup(each.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name)
  scale_units         = lookup(each.value, "scale_units", 1)
  virtual_hub_id      = azurerm_virtual_hub.virtual_hub[lookup(each.value, "virtual_hub_name", null)].id

  tags = var.common_tags
}

resource "azurerm_express_route_connection" "express_route_connection" {
  for_each = var.express_route_connections

  name                             = each.key
  express_route_circuit_peering_id = each.value.peering_id
  express_route_gateway_id         = each.value.gateway_id
}
