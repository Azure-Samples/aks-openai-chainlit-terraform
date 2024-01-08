variable "name" {
  description = "(Required) Specifies the name of the Azure Managed Grafana resource."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group. of the Azure Managed Grafana resource."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location where the Azure Managed Grafana resource will be deployed."
  type        = string
}

variable "api_key_enabled" {
  description = "(Optional) Specifies whether to enable the API key setting of the Azure Managed Grafana resource. Defaults to false"
  type        = bool
  default     = true
}

variable "auto_generated_domain_name_label_scope" {
  description = "(Optional)  Specifies the scope for DNS deterministic name hash calculation. The only possible value is TenantReuse. Defaults to TenantReuse."
  type        = string
  default     = "TenantReuse"
}

variable "deterministic_outbound_ip_enabled" {
  description = "(Optional) Specifies whether to enable the Azure Managed Grafana resource to use deterministic outbound IPs. Defaults to false."
  type        = bool
  default     = false  
}

variable "public_network_access_enabled" {
  description = "(Optional) Specifies whether to enable traffic over the public interface. Defaults to true."
  type        = bool
  default     = true
}

variable "azure_monitor_workspace_id" {
  description = "(Required) Specifies the resource id of the Azure Monitor Workspace to integrate with Grafana."
  type        = string
}

variable "sku" {
  description = "(Optional) Specifies the name of the SKU used for the Azure Managed Grafana resource. Possible values are Standard and Essential. Defaults to Standard. Changing this forces a new Dashboard Grafana to be created."
  type        = string
  default     = "Standard"
}

variable "zone_redundancy_enabled" {
  description = "(Optional) Specifies whether to enable zone redundancy for the Azure Managed Grafana resource. Defaults to false. Changing this forces a new Dashboard Grafana to be created."
  type        = bool
  default     = false
}

variable "admin_group_object_id" {
  description = "(Required) The object id of a Microsoft Entra ID group of users who should be assigned the Grafana Admin role over the Azure Managed Grafana resource."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Azure Managed Grafana resource."
  default     = {}
}