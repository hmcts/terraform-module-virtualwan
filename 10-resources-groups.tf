resource "azurerm_resource_group" "virtual_wan_resource_group" {
  location = var.location
  name     = var.resource_group_name != null ? var.resource_group_name : format("%s-%s", var.name, var.environment)

  tags = var.common_tags
}
