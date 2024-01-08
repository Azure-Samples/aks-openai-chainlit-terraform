variable "name" {
  description = "(Required) Specifies the name of the Azure Deployment Script  resource."
  type = string
  default = "BashScript"
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group."
  type = string
}

variable "location" {
  description = "(Required) Specifies the location of the Azure Deployment Script  resource."
  type = string
}

variable "azure_cli_version" {
  description = "(Required) Azure CLI module version to be used."
  type = string
  default = "2.9.1"
}

variable "managed_identity_name" {
  description = "Specifies the name of the user-defined managed identity used by the deployment script."
  type = string
  default = "ScriptManagedIdentity"
}

variable "primary_script_uri" {
  description = "(Optional) Uri for the script. This is the entry point for the external script. Changing this forces a new Resource Deployment Script to be created."
  type = string
}

variable "aks_cluster_id" {
  description = "(Required) Specifies the resource id of the AKS cluster."
  type = string
}

variable "tenant_id" {
  description = "(Required) Specifies the Azure AD tenant id."
  type = string
}

variable "subscription_id" {
  description = "(Required) Specifies the Azure subscription id."
  type = string
}

variable "hostname" {
  description = "(Optional) Specifies the hostname of the application."
  type = string
}

variable "namespace" {
  description = "(Required) Specifies the namespace of the application."
  type = string
}

variable "service_account_name" {
  description = "(Required) Specifies the service account of the application."
  type = string
}

variable "workload_managed_identity_client_id" {
  description = "(Required) Specifies the client id of the workload user-defined managed identity."
  type = string
}

variable "email" {
  description = "(Required) Specifies the email address for the cert-manager cluster issuer."
  type = string
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Azure Deployment Script resource."
  type        = map(any)
  default     = {}
}