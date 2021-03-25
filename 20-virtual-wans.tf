resource "azurerm_virtual_wan" "virtual_wan" {
  allow_branch_to_branch_traffic                = var.virtual_wan_allow_branch_to_branch_traffic
  disable_vpn_encryption                        = var.virtual_wan_disable_vpn_encryption
  location                                      = azurerm_resource_group.virtual_wan_resource_group.location
  name                                          = var.virtual_wan_name != null ? var.virtual_wan_name : format("%s-%s", var.name, var.environment)
  virtual_wan_office365_local_breakout_category = var.office365_local_breakout_category
  resource_group_name                           = azurerm_resource_group.virtual_wan_resource_group.name
  type                                          = var.virtual_wan_type

  tags = var.common_tags
}
