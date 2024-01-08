output "name" {
  value = azurerm_monitor_workspace.workspace.name
  description = "Specifies the name of the Azure Managed Prometheus workspace."
}

output "id" {
  value = azurerm_monitor_workspace.workspace.id
  description = "Specifies the resource id of the Azure Managed Prometheus workspace."
}