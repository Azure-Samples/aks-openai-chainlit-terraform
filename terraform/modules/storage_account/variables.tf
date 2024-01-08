variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group. of the Azure Storage Account"
  type        = string
}

variable "name" {
  description = "(Required) Specifies the name of the Azure Storage Account"
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location of the Azure Storage Account"
  type        = string
}

variable "account_kind" {
  description = "(Optional) Specifies the account kind of the Azure Storage Account"
  default     = "StorageV2"
  type        = string

   validation {
    condition = contains(["Storage", "StorageV2"], var.account_kind)
    error_message = "The account kind of the Azure Storage Account is invalid."
  }
}

variable "account_tier" {
  description = "(Optional) Specifies the account tier of the Azure Storage Account"
  default     = "Standard"
  type        = string

   validation {
    condition = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The account tier of the Azure Storage Account is invalid."
  }
}

variable "replication_type" {
  description = "(Optional) Specifies the replication type of the Azure Storage Account"
  default     = "LRS"
  type        = string

  validation {
    condition = contains(["LRS", "ZRS", "GRS", "GZRS", "RA-GRS", "RA-GZRS"], var.replication_type)
    error_message = "The replication type of the Azure Storage Account is invalid."
  }
}

variable "is_hns_enabled" {
  description = "(Optional) Specifies the replication type of the Azure Storage Account"
  default     = false
  type        = bool
}

variable "default_action" {
    description = "Allow or disallow public access to all blobs or containers in the Azure Storage Accounts. The default interpretation is true for this property."
    default     = "Allow"
    type        = string  
}

variable "ip_rules" {
    description = "Specifies IP rules for the Azure Storage Account"
    default     = []
    type        = list(string)  
}

variable "virtual_network_subnet_ids" {
    description = "Specifies a list of resource ids for subnets"
    default     = []
    type        = list(string)  
}

variable "kind" {
  description = "(Optional) Specifies the kind of the Azure Storage Account"
  default     = ""
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Azure Storage Account"
  default     = {}
}