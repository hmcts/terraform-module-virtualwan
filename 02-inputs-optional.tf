# General
variable "common_tags" {
  description = "Common tag to be applied to resources"
  type        = map(string)
  default     = []
}

variable "location" {
  description = "Target Azure location to deploy the resource."
  type        = string
  default     = "UK South"
}

variable "resource_group_name" {
  description = "Enter Resource Group name."
  type        = string
  default     = null
}

# Virtual Hub
variable "enable_virtual_hub" {
  description = "Enable Azure Virtual Hub."
  type        = bool
  default     = true
}

variable "virtual_hub_address_prefix" {
  description = "The Address Prefix which should be used for this Virtual Hub. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "virtual_hub_name" {
  description = "Enter VirtualHub name."
  type        = string
  default     = null
}

variable "virtual_hub_routes" {
  description = "A comma-delimited list of address prefixes and the next hop IP address - Example: {a = b, c = d}"
  type        = list(map(string))
  default     = []
}

variable "virtual_hub_sku" {
  description = "The sku of the Virtual Hub. Possible values are Basic and Standard. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"
}

# Virtual WAN
variable "virtual_wan_allow_branch_to_branch_traffic" {
  description = "Boolean flag to specify whether branch to branch traffic is allowed."
  type        = bool
  default     = true
}

variable "virtual_wan_disable_vpn_encryption" {
  description = "Boolean flag to specify whether VPN encryption is disabled."
  type        = bool
  default     = false
}

variable "virtual_wan_name" {
  description = "Specifies the name of the Virtual WAN. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "virtual_wan_office365_local_breakout_category" {
  description = "Specifies the Office365 local breakout category. Possible values include: Optimize, OptimizeAndAllow, All, None."
  type        = string
  default     = "None"
}

variable "virtual_wan_type" {
  description = "Specifies the Virtual WAN type. Possible Values include: Basic and Standard."
  type        = string
  default     = "Standard"
}
