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
      address_prefixes    = split(",", replace(lookup(route.value, "address_prefixes", null), " ", ""))
      next_hop_ip_address = route.value["next_hop_ip_address"]
    }
  }
  sku            = lookup(each.value, "sku", null)
  virtual_wan_id = azurerm_virtual_wan.virtual_wan[lookup(each.value, "virtual_wan_name", null)].id

  tags = var.common_tags

  default_route_table {
    labels = lookup(var.virtual_hub_default_route_table_labels, each.key, null) != null ? lookup(var.virtual_hub_default_route_table_labels, each.key, null) : []

    dynamic "route" {
      for_each = lookup(var.virtual_hub_default_route_table_routes, each.key, null) != null ? lookup(var.virtual_hub_default_route_table_routes, each.key, null) : []
      content {
        destinations      = [route.value["destinations"]]
        destinations_type = route.value["destinations_type"]
        name              = route.value["name"]
        next_hop          = route.value["next_hop"]
        next_hop_type     = lookup(route.value, "next_hop_type", "ResourceId")
      }
    }
  }
}

# Virtual Hub Connections
resource "azurerm_virtual_hub_connection" "virtual_hub_connection" {
  for_each = var.virtual_hub_connections

  internet_security_enabled = lookup(each.value, "internet_security_enabled", false)
  name                      = each.key
  remote_virtual_network_id = lookup(each.value, "remote_virtual_network_id", null)
  virtual_hub_id            = azurerm_virtual_hub.virtual_hub[lookup(each.value, "virtual_hub_name", null)].id

  dynamic "routing" {
    for_each = { for k, r in var.virtual_hub_connection_routing : k => r if k == each.key }
    content {
      associated_route_table_id = lookup(routing.value, "associated_route_table_name", null) == "default" ? format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualHubs/%s/hubRouteTables/defaultRouteTable", data.azurerm_subscription.current.subscription_id, lookup(routing.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name), lookup(each.value, "virtual_hub_name", null)) : lookup(routing.value, "associated_route_table_name", null) != null ? azurerm_virtual_hub_route_table.virtual_hub_route_table[lookup(routing.value, "associated_route_table_name", null)].id : null
      dynamic "propagated_route_table" {
        for_each = { for k, r in var.virtual_hub_connection_propagated_route_tables : k => r if k == each.key }
        iterator = propagated
        content {
          labels          = lookup(propagated.value, "labels", null) != null ? split(",", replace(lookup(propagated.value, "labels", null), " ", "")) : []
          route_table_ids = lookup(propagated.value, "route_table_names", null) != null ? contains(sort(split(",", replace(lookup(propagated.value, "route_table_names", null), " ", ""))), "default") ? concat([format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualHubs/%s/hubRouteTables/defaultRouteTable", data.azurerm_subscription.current.subscription_id, lookup(routing.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name), lookup(each.value, "virtual_hub_name", null))], [for i in sort(split(",", replace(lookup(propagated.value, "route_table_names", null), " ", ""))) : azurerm_virtual_hub_route_table.virtual_hub_route_table[i].id if i != "default"]) : [for i in sort(split(",", replace(lookup(propagated.value, "route_table_names", null), " ", ""))) : azurerm_virtual_hub_route_table.virtual_hub_route_table[i].id if i != "default"] : []
        }
      }
      dynamic "static_vnet_route" {
        for_each = lookup(var.virtual_hub_connection_static_vnet_routes, each.key, null) != null ? lookup(var.virtual_hub_connection_static_vnet_routes, each.key, null) : []
        iterator = static
        content {
          address_prefixes    = [static.value["address_prefixes"]]
          name                = static.value["name"]
          next_hop_ip_address = static.value["next_hop_ip_address"]
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
}

resource "azurerm_virtual_hub_route_table_route" "virtual_hub_route_table_route" {
  for_each          = var.virtual_hub_route_table_routes
  route_table_id    = azurerm_virtual_hub_route_table.virtual_hub_route_table[each.value.route_table_name].id
  destinations      = each.value.destinations
  destinations_type = each.value.destinations_type
  next_hop          = azurerm_virtual_hub_connection.virtual_hub_connection[each.value.next_hop].id
  next_hop_type     = each.value.next_hop_type
  name              = each.key
}
