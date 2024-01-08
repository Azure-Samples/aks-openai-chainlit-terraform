variable "name" {
  description = "(Required) Specifies the name of the Azure Bastion Host resource."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group. of the Azure Bastion Host resource."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location of the Azure Bastion Host resource."
  type        = string
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Azure Bastion Host resource."
  default     = {}
}

variable "subnet_id" {
  description = "(Required) Specifies subnet id of the Azure Bastion Host resource."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Specifies the resource id of the Azure Log Analytics workspace."
  type        = string
}