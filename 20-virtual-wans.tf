resource "azurerm_virtual_wan" "virtual_wan" {
  for_each = var.virtual_wans

  allow_branch_to_branch_traffic    = lookup(each.value, "allow_branch_to_branch_traffic", true)
  disable_vpn_encryption            = lookup(each.value, "disable_vpn_encryption", false)
  location                          = lookup(each.value, "location", azurerm_resource_group.virtual_wan_resource_group[0].location)
  name                              = each.key
  office365_local_breakout_category = lookup(each.value, "office365_local_breakout_category", "None")
  resource_group_name               = lookup(each.value, "resource_group_name", azurerm_resource_group.virtual_wan_resource_group[0].name)
  type                              = lookup(each.value, "type", "Standard")

  tags = var.common_tags
}
