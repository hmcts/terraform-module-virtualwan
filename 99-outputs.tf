output "resource_group_location" {
  value = var.resource_group_name != null ? azurerm_resource_group.virtual_wan_resource_group[0].location : null
}

output "resource_group_name" {
  value = var.resource_group_name != null ? azurerm_resource_group.virtual_wan_resource_group[0].name : null
}

output "virtual_hub_connection_ids" {
  value = tomap({
    for connection in azurerm_virtual_hub_connection.virtual_hub_connection : connection.name => connection.id
  })
}
