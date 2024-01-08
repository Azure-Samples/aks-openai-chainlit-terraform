variable "name" {
  description = "(Required) Specifies the name of the Azure Managed Prometheus resource."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group. of the Azure Managed Prometheus resource."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location where the Azure Managed Prometheus resource will be deployed."
  type        = string
}

variable "public_network_access_enabled" {
  description = "(Optional) Specifies whether to enable traffic over the public interface. Defaults to true."
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Azure Managed Grafana resource."
  default     = {}
}

variable "aks_cluster_id" {
  description = "(Required) Specifies the resource id of the AKS cluster."
  type        = string
}