variable "kubernetes_config_path" {
  description = "(Optional) A path to a kube config file. Can be sourced from KUBE_CONFIG_PATH"
  type        = string
  default     = null
}

variable "kubernetes_config_context" {
  description = "(Optional) Context to choose from the config file. Can be sourced from KUBE_CTX."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "(Required) Specifies the Azure AD tenant id."
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

variable "nginx_replica_count" {
  description = "(Optional) Specifies the number of replicas for the nginx ingress controller."
  type = number
  default = 3
}

variable "host" {
  description = "The host in the azurerm_kubernetes_cluster's kube_admin_config block. The Kubernetes cluster server host."
  type = string
}

variable "username" {
  description = "The username in the azurerm_kubernetes_cluster's kube_admin_config block. A username used to authenticate to the Kubernetes cluster."
  type = string
}

variable "password" {
  description = "The password in the azurerm_kubernetes_cluster's kube_admin_config block. A password or token used to authenticate to the Kubernetes cluster."
  sensitive = true
  type = string
}

variable "client_certificate" {
  description = "The client_certificate in the azurerm_kubernetes_cluster's kube_admin_config block.  Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  sensitive = true
  type = string
}

variable "client_key" {
  description = "The client_key in the azurerm_kubernetes_cluster's kube_admin_config block. Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
  sensitive = true
  type = string
}

variable "cluster_ca_certificate" {
  description = "The cluster_ca_certificate in the azurerm_kubernetes_cluster's kube_admin_config block. Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
  sensitive = true
  type = string
}