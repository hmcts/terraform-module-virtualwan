output "virtual_hub_connection_ids" {
  value = tomap({
    for connection in azurerm_virtual_hub_connection.virtual_hub_connection : connection.name => connection.id
  })
}
