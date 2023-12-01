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

variable "express_route_connections" {
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
  type = map(object({
    labels           = optional(list(string))
    virtual_hub_name = string
  }))
  default = {}
}

variable "virtual_hub_route_table_routes" {
  type    = map(list(map(string)))
  default = {}
}

# VPN Sites
variable "vpn_gateways" {
  type = map(object({
    location            = optional(string)
    resource_group_name = optional(string)
    scale_unit          = optional(number, 1)
    virtual_hub_name    = string
  }))
  default = {}
}

variable "vpn_sites" {
  type = map(object({
    address_cidrs       = optional(list(string), [])
    device_model        = optional(string, null)
    device_vendor       = optional(string, null)
    location            = optional(string)
    resource_group_name = optional(string)
    virtual_wan_name    = string
  }))
  default = {}
}

variable "vpn_site_links" {
  type = map(list(object({
    asn             = optional(string, null)
    ip_address      = string
    name            = string
    peering_address = optional(string, null)
    provider_name   = string
    speed_in_mbps   = number
    fqdn            = optional(string, null)
  })))
  default = {}
}

variable "vpn_gateway_connections" {
  type = map(object({
    vpn_gateway_id       = string
    remote_vpn_site_name = string
  }))
  default = {}
}

variable "vpn_gateway_connections_links" {
  type = map(list(object({
    name                           = string
    vpn_site_link_name             = optional(string, null)
    bgp_enabled                    = optional(bool, true)
    egress_nat_rule_ids            = optional(list(string), [])
    ingress_nat_rule_ids           = optional(list(string), [])
    protocol                       = optional(string, "IKEv2")
    local_azure_ip_address_enabled = optional(bool, false)
    route_weight                   = optional(number, 0)
  })))
  default = {}
}
