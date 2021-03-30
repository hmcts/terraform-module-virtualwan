resource "azurerm_resource_group" "virtual_wan_resource_group" {
  count = var.resource_group_name != null ? 1 : 0

  location = var.location
  name     = var.resource_group_name

  tags = var.common_tags
}
