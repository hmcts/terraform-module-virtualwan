# Express Route Circuits
variable "enable_express_route_circuit" {
  description = "Enable Azure Express Route Circuit."
  type        = bool
  default     = true
}

variable "express_route_circuit_allow_classic_operations" {
  description = "Allow the circuit to interact with classic (RDFE) resources."
  type        = bool
  default     = false
}

variable "express_route_circuit_bandwidth_in_mbps" {
  description = "The bandwidth in Mbps of the circuit being created."
  type        = number
  default     = 2000
}

variable "express_route_circuit_name" {
  description = "Enter ExressRoute Circuit name."
  type        = string
  default     = null
}

variable "express_route_circuit_peering_location" {
  description = "The name of the peering location and not the Azure resource location."
  type        = string
  default     = "London"
}

variable "express_route_circuit_service_provider_name" {
  description = "The name of the ExpressRoute Service Provider."
  type        = string
  default     = "Equinix"
}

variable "express_route_circuit_sku_family" {
  description = "Enter ExressRoute Circuit name."
  type        = string
  default     = "MeteredData"
}

variable "express_route_circuit_sku_tier" {
  description = "Enter ExressRoute Circuit name."
  type        = string
  default     = "Premium"
}

# General
variable "common_tags" {
  description = "Common tag to be applied to resources"
  type        = map(string)
  default     = {}
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
