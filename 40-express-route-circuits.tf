resource "azurerm_express_route_circuit" "express_route_circuit" {
  count = var.enable_express_route_circuit ? 1 : 0

  allow_classic_operations = var.express_route_circuit_allow_classic_operations
  bandwidth_in_mbps        = var.express_route_circuit_bandwidth_in_mbps
  location                 = azurerm_resource_group.virtual_wan_resource_group.location
  name                     = var.express_route_circuit_name != null ? var.express_route_circuit_name : format("%s-%s", var.name, var.environment)
  peering_location         = var.express_route_circuit_peering_location
  resource_group_name      = azurerm_resource_group.virtual_wan_resource_group.name
  service_provider_name    = var.express_route_circuit_service_provider_name
  sku {
    family = var.express_route_circuit_sku_family
    tier   = var.express_route_circuit_sku_tier
  }

  tags = var.common_tags
}
