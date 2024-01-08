variable "name" {
  description = "Specifies the Azure Firewall name"
  type        = string
}

variable "sku_name" {
  description = "(Required) SKU name of the Azure Firewall. Possible values are AZFW_Hub and AZFW_VNet. Changing this forces a new resource to be created."
  default     = "AZFW_VNet"
  type        = string

  validation {
    condition = contains(["AZFW_Hub", "AZFW_VNet" ], var.sku_name)
    error_message = "The value of the sku name property of the Azure Firewall is invalid."
  }
}

variable "sku_tier" {
  description = "(Required) SKU tier of the Azure Firewall. Possible values are Premium, Standard, and Basic."
  default     = "Standard"
  type        = string

  validation {
    condition = contains(["Premium", "Standard", "Basic" ], var.sku_tier)
    error_message = "The value of the sku tier property of the Azure Firewall is invalid."
  }
}

variable "resource_group_name" {
  description = "Specifies the name of the resource group."
  type        = string
}

variable "location" {
  description = "Specifies the location where Azure Firewall will be deployed"
  type        = string
}

variable "threat_intel_mode" {
  description = "(Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert, Deny. Defaults to Alert."
  default     = "Alert"
  type        = string

  validation {
    condition = contains(["Off", "Alert", "Deny"], var.threat_intel_mode)
    error_message = "The threat intel mode is invalid."
  }
}

variable "zones" {
  description = "Specifies the availability zones of the Azure Azure Firewall"
  default     = ["1", "2", "3"]
  type        = list(string)
}

variable "pip_name" {
  description = "Specifies the Azure Firewall public IP name"
  type        = string
  default     = "azure-fw-ip"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Azure Azure Firewall resource."
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "Specifies the resource id of the Azure Log Analytics workspace."
  type        = string
}