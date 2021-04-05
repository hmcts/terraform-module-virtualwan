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
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  for_each = var.virtual_network_gateways

  active_active                    = lookup(each.value, "active_active", false)
  default_local_network_gateway_id = lookup(each.value, "default_local_network_gateway_id", null)
  enable_bgp                       = lookup(each.value, "enable_bgp", false)
  generation                       = lookup(each.value, "generation", null)
  location                         = lookup(each.value, "location", azurerm_resource_group.virtual_wan_resource_group[0].location)
  name                             = each.key
  private_ip_address_enabled       = lookup(each.value, "private_ip_address_enabled", null)
  resource_group_name              = lookup(each.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name)
  sku                              = lookup(each.value, "sku", null)
  type                             = lookup(each.value, "type", null)
  vpn_type                         = lookup(each.value, "vpn_type", null)

  dynamic "ip_configuration" {
    for_each = lookup(var.virtual_network_gateway_ip_configurations, each.key, null) != null ? lookup(var.virtual_network_gateway_ip_configurations, each.key, null) : []
    content {
      name                          = lookup(ip_configuration.value, "name", null)
      private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation", null)
      public_ip_address_id          = lookup(ip_configuration.value, "public_ip_address_id", null)
      subnet_id                     = lookup(ip_configuration.value, "subnet_id", null)
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = lookup(var.virtual_network_gateway_vpn_client_configurations, each.key, {}) != {} ? lookup(var.virtual_network_gateway_vpn_client_configurations, each.key, {}) : {}
    content {
      aad_audience          = lookup(vpn_client_configuration.value, "aad_audience", null)
      aad_issuer            = lookup(vpn_client_configuration.value, "aad_issuer", null)
      aad_tenant            = lookup(vpn_client_configuration.value, "aad_tenant", null)
      address_space         = lookup(vpn_client_configuration.value, "address_space", null)
      radius_server_address = lookup(vpn_client_configuration.value, "radius_server_address", null)
      radius_server_secret  = lookup(vpn_client_configuration.value, "radius_server_secret", null)
      dynamic "revoked_certificate" {
        for_each = lookup(var.virtual_network_gateway_revoked_certificates, each.key, null) != null ? lookup(var.virtual_network_gateway_revoked_certificates, each.key, null) : []
        content {
          name       = lookup(revoked_certificate.value, "name", null)
          thumbprint = lookup(revoked_certificate.value, "thumbprint", null)
        }
      }
      dynamic "root_certificate" {
        for_each = lookup(var.virtual_network_gateway_root_certificates, each.key, null) != null ? lookup(var.virtual_network_gateway_root_certificates, each.key, null) : []
        content {
          name             = lookup(root_certificate.value, "name", null)
          public_cert_data = lookup(root_certificate.value, "public_cert_data", null)
        }
      }
      vpn_client_protocols = lookup(vpn_client_configuration.value, "vpn_client_protocols", null)
    }
  }

  dynamic "bgp_settings" {
    for_each = lookup(var.virtual_network_gateway_bgp_settings, each.key, null) != null ? lookup(var.virtual_network_gateway_bgp_settings, each.key, null) : {}
    content {
      asn = lookup(bgp_settings.value, "asn", null)
      dynamic "peering_addresses" {
        for_each = lookup(var.virtual_network_gateway_peering_addresses, each.key, null) != null ? lookup(var.virtual_network_gateway_peering_addresses, each.key, null) : []
        content {
          apipa_addresses       = lookup(peering_addresses.value, "apipa_addresses", null) != null ? split(",", replace(lookup(peering_addresses.value, "apipa_addresses", null), " ", "")) : []
          ip_configuration_name = lookup(peering_addresses.value, "ip_configuration_name", null)
        }
      }
      peer_weight = lookup(bgp_settings.value, "peer_weight", null)
    }
  }

  dynamic "custom_route" {
    for_each = lookup(var.virtual_network_gateway_custom_routes, each.key, {}) != {} ? lookup(var.virtual_network_gateway_custom_routes, each.key, {}) : {}
    content {
      address_prefixes = lookup(custom_route.value, "address_prefixes", null) != null ? split(",", replace(lookup(custom_route.value, "address_prefixes", null), " ", "")) : []
    }
  }

  tags = var.common_tags
}

resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection" {
  for_each = var.virtual_network_gateway_connections

  authorization_key               = lookup(each.value, "express_route_circuit_authorization_name", null) != null ? azurerm_express_route_circuit_authorization.express_route_circuit_authorization[lookup(each.value, "express_route_circuit_authorization_name", null)].id : null
  express_route_circuit_id        = lookup(each.value, "express_route_circuit_name", null) != null ? azurerm_express_route_circuit.express_route_circuit[lookup(each.value, "express_route_circuit_name", null)].id : null
  location                        = lookup(each.value, "location", azurerm_resource_group.virtual_wan_resource_group[0].location)
  name                            = each.key
  peer_virtual_network_gateway_id = lookup(each.value, "peer_virtual_network_gateway_id", null)
  resource_group_name             = lookup(each.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name)
  routing_weight                  = lookup(each.value, "routing_weight", 10)
  shared_key                      = lookup(each.value, "shared_key", null)
  type                            = lookup(each.value, "type", null)
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.virtual_network_gateway[lookup(each.value, "virtual_network_gateway_name", null)].id

  tags = var.common_tags
}
