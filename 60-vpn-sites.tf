resource "azurerm_vpn_gateway" "example" {
  for_each = var.vpn_gateways

  location            = each.value.location == null ? azurerm_resource_group.virtual_wan_resource_group[0].location : each.value.location
  name                = each.key
  resource_group_name = each.value.resource_group_name == null ? azurerm_resource_group.virtual_wan_resource_group[0].name : each.value.resource_group_name
  scale_unit          = each.value.scale_unit
  virtual_hub_id      = azurerm_virtual_hub.virtual_hub[each.value.virtual_hub_name].id
  tags                = var.common_tags
}

resource "azurerm_vpn_site" "vpn_site" {
  for_each = var.vpn_sites

  address_cidrs = each.value.address_cidrs
  device_model  = each.value.device_model
  device_vendor = each.value.device_vendor
  dynamic "link" {
    for_each = lookup(var.vpn_site_links, each.key, [])
    content {
      dynamic "bgp" {
        for_each = link.value.asn != null ? [1] : []
        content {
          asn             = link.value.asn
          peering_address = link.value.peering_address
        }
      }
      fqdn          = link.value.fqdn
      ip_address    = link.value.ip_address
      name          = link.value.name
      provider_name = link.value.provider_name
      speed_in_mbps = link.value.speed_in_mbps
    }
  }
  location            = each.value.location != null ? each.value.location : azurerm_resource_group.virtual_wan_resource_group[0].location
  name                = each.key
  resource_group_name = each.value.resource_group_name != null ? each.value.resource_group_name : azurerm_resource_group.virtual_wan_resource_group[0].name
  virtual_wan_id      = azurerm_virtual_wan.virtual_wan[each.value.virtual_wan_name].id

  tags = var.common_tags
}

resource "azurerm_vpn_gateway_connection" "vpn_gateway_connections" {
  for_each = var.vpn_gateway_connections

  name               = each.key
  vpn_gateway_id     = each.value.vpn_gateway_id
  remote_vpn_site_id = azurerm_vpn_site.vpn_site[each.value.remote_vpn_site_name].id

  dynamic "vpn_link" {
    for_each = lookup(var.vpn_gateway_connections_links, each.key, [])
    content {
      name                           = vpn_link.value.name
      vpn_site_link_id               = azurerm_vpn_site.vpn_site[each.value.remote_vpn_site_name].link[[for key, value in lookup(var.vpn_site_links, each.value.remote_vpn_site_name) : key if value.name == (vpn_link.value.vpn_site_link_name != null ? vpn_link.value.vpn_site_link_name : vpn_link.value.name)][0]].id
      bgp_enabled                    = vpn_link.value.bgp_enabled
      egress_nat_rule_ids            = vpn_link.value.egress_nat_rule_ids
      ingress_nat_rule_ids           = vpn_link.value.ingress_nat_rule_ids
      protocol                       = vpn_link.value.protocol
      local_azure_ip_address_enabled = vpn_link.value.local_azure_ip_address_enabled
      route_weight                   = vpn_link.value.route_weight
    }
  }

  lifecycle {
    ignore_changes = [
      vpn_link[0].shared_key,
      vpn_link[1].shared_key
    ]
  }
}
