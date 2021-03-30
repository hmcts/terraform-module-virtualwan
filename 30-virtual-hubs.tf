# Virtual Hubs
resource "azurerm_virtual_hub" "virtual_hub" {
  for_each = var.virtual_hubs

  address_prefix      = lookup(each.value, "address_prefix", null)
  location            = lookup(each.value, "location", azurerm_resource_group.virtual_wan_resource_group[0].location)
  name                = each.key
  resource_group_name = lookup(each.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name)
  dynamic "route" {
    for_each = lookup(var.virtual_hub_routes, each.key, null) != null ? lookup(var.virtual_hub_routes, each.key, null) : []
    content {
      address_prefixes    = [route.value["address_prefixes"]]
      next_hop_ip_address = route.value["next_hop_ip_address"]
    }
  }
  sku            = lookup(each.value, "sku", "Standard")
  virtual_wan_id = azurerm_virtual_wan.virtual_wan[lookup(each.value, "virtual_wan_name", null)].id

  tags = var.common_tags
}

# Virtual Hub Connections
resource "azurerm_virtual_hub_connection" "virtual_hub_connection" {
  for_each = var.virtual_hub_connections

  internet_security_enabled = lookup(each.value, "internet_security_enabled", false)
  name                      = each.key
  remote_virtual_network_id = lookup(each.value, "remote_virtual_network_id", null)
  virtual_hub_id            = azurerm_virtual_hub.virtual_hub[lookup(each.value, "virtual_hub_name", null)].id

  dynamic "routing" {
    for_each = lookup(var.virtual_hub_connection_routing, each.key, {}) != {} ? lookup(var.virtual_hub_connection_routing, each.key, {}) : {}
    content {
      associated_route_table_id = azurerm_virtual_hub_route_table.virtual_hub_route_table[lookup(routing.value, "associated_route_table_name", null)].id
      dynamic "propagated_route_table" {
        for_each = lookup(var.virtual_hub_connection_propagated_route_tables, each.key, {}) != {} ? lookup(var.virtual_hub_connection_propagated_route_tables, each.key, {}) : {}
        content {
          labels          = lookup(propagated_route_table.value, "labels", null) != null ? split(",", replace(lookup(propagated_route_table.value, "labels", null), " ", "")) : []
          route_table_ids = lookup(propagated_route_table.value, "route_table_names", null) != null ? [for i in sort(split(",", replace(lookup(propagated_route_tables.value, "route_table_names", null), " ", ""))) : azurerm_virtual_hub_route_tables.virtual_hub_route_table[i].id] : []
        }
      }
      dynamic "static_vnet_route" {
        for_each = lookup(var.virtual_hub_connection_static_vnet_routes, each.key, {}) != {} ? lookup(var.virtual_hub_connection_static_vnet_routes, each.key, {}) : {}
        content {
          address_prefixes    = [static_vnet_route.value["address_prefixes"]]
          name                = static_vnet_route.value["name"]
          next_hop_ip_address = static_vnet_route.value["next_hop_ip_address"]
        }
      }
    }
  }
}

# Virtual Hub Route Tables
resource "azurerm_virtual_hub_route_table" "virtual_hub_route_table" {
  for_each = var.virtual_hub_route_tables

  labels         = lookup(each.value, "labels", null) != null ? split(",", replace(lookup(each.value, "labels", null), " ", "")) : []
  name           = each.key
  virtual_hub_id = azurerm_virtual_hub.virtual_hub[lookup(each.value, "virtual_hub_name", null)].id

  dynamic "route" {
    for_each = lookup(var.virtual_hub_route_table_routes, each.key, null) != null ? lookup(var.virtual_hub_route_table_routes, each.key, null) : []
    content {
      destinations      = [route.value["destinations"]]
      destinations_type = route.value["destinations_type"]
      name              = route.value["name"]
      next_hop          = route.value["next_hop"]
      next_hop_type     = lookup(route.value, "next_hop_type", "ResourceId")
    }
  }
}
