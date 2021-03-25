resource "azurerm_virtual_hub" "virtual_hub" {
  count = var.enable_virtual_hub ? 1 : 0

  address_prefix      = var.virtual_hub_address_prefix
  location            = azurerm_resource_group.virtual_wan_resource_group.location
  name                = var.virtual_hub_name != null ? var.virtual_hub_name : format("%s-%s", var.name, var.environment)
  resource_group_name = azurerm_resource_group.virtual_wan_resource_group.name
  dynamic "route" {
    for_each = var.virtual_hub_routes
    content {
      address_prefixes    = tolist(virtual_hub_routes.value["address_prefixes"])
      next_hop_ip_address = virtual_hub_routes.value["next_hop_ip_address"]
    }
  }
  sku            = var.virtual_hub_sku
  virtual_wan_id = azurerm_virtual_wan.virtual_wan.id

  tags = var.common_tags
}
