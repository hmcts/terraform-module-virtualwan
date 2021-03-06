# Express Route Circuits
variable "express_route_circuits" {
  type    = map(map(any))
  default = {}
}

variable "express_route_circuit_authorizations" {
  type    = map(map(any))
  default = {}
}

variable "express_route_circuit_peerings" {
  type    = map(map(any))
  default = {}
}

variable "express_route_gateways" {
  type    = map(map(any))
  default = {}
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

# Virtual Network Gateways
variable "virtual_network_gateways" {
  type    = map(map(any))
  default = {}
}

variable "virtual_network_gateway_ip_configurations" {
  type    = map(list(map(string)))
  default = {}
}

variable "virtual_network_gateway_vpn_client_configurations" {
  type    = map(map(any))
  default = {}
}

variable "virtual_network_gateway_revoked_certificates" {
  type    = map(list(map(string)))
  default = {}
}

variable "virtual_network_gateway_root_certificates" {
  type    = map(list(map(string)))
  default = {}
}

variable "virtual_network_gateway_bgp_settings" {
  type    = map(map(any))
  default = {}
}

variable "virtual_network_gateway_peering_addresses" {
  type    = map(list(map(string)))
  default = {}
}

variable "virtual_network_gateway_custom_routes" {
  type    = map(map(any))
  default = {}
}

variable "virtual_network_gateway_connections" {
  type    = map(map(any))
  default = {}
}

# Virtual Hub
variable "virtual_hubs" {
  type    = map(map(any))
  default = {}
}

variable "virtual_hub_routes" {
  type    = map(list(map(string)))
  default = {}
}

variable "virtual_hub_connections" {
  type    = map(map(any))
  default = {}
}

variable "virtual_hub_connection_routing" {
  type    = map(map(any))
  default = {}
}

variable "virtual_hub_connection_propagated_route_tables" {
  type    = map(map(any))
  default = {}
}

variable "virtual_hub_connection_static_vnet_routes" {
  type    = map(list(map(string)))
  default = {}
}

variable "virtual_hub_route_tables" {
  type    = map(map(any))
  default = {}
}

variable "virtual_hub_route_table_routes" {
  type    = map(list(map(string)))
  default = {}
}

# VPN Sites
variable "vpn_sites" {
  type    = map(map(any))
  default = {}
}

variable "vpn_site_links" {
  type    = map(list(map(string)))
  default = {}
}
