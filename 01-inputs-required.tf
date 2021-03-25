# General
variable "name" {
  description = "Name to be used when creating the resources.."
  type        = string
}

variable "environment" {
  description = "Environment e.g. development, testing, staging, production."
  type        = string
}
