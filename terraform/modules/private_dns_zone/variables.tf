variable "name" {
  description = "(Required) Specifies the name of the Azure Private DNS Zone"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group. of the Azure Private DNS Zone"
  type        = string
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Azure Private DNS Zone"
  default     = {}
}

variable "virtual_networks_to_link" {
  description = "(Optional) Specifies the subscription id, resource group name, and name of the virtual networks to which create a virtual network link"
  type        = map(any)
  default     = {}
}