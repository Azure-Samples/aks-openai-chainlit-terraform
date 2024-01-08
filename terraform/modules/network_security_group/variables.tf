variable "name" {
  description = "(Required) Specifies the name of the Azure Network Security Group"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group. of the Azure Network Security Group"
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location of the Azure Network Security Group"
  type        = string
}

variable "security_rules" {
  description = "(Optional) Specifies the security rules of the Azure Network Security Group"
  type        = list(object)
  default     = []
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Azure Network Security Group"
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "Specifies the resource id of the Azure Log Analytics workspace"
  type        = string
}
