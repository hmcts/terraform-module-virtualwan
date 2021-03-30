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

variable "virtual_network_gateway_connections" {
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

# Virtual Hub
variable "virtual_hubs" {
  type    = map(map(any))
  default = {}
}

variable "virtual_hub_routes" {
  description = "A comma-delimited list of address prefixes and the next hop IP address - Example: {a = b, c = d}"
  type        = map(list(map(string)))
  default     = {}
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
  type    = map(map(any))
  default = {}
}

variable "virtual_hub_route_tables" {
  type    = map(map(any))
  default = {}
}

variable "virtual_hub_route_table_routes" {
  description = "A comma-delimited list of address prefixes and the next hop IP address - Example: {a = b, c = d}"
  type        = map(list(map(string)))
  default     = {}
}
