output "name" {
  value = azurerm_dashboard_grafana.grafana.name
  description = "Specifies the name of the Azure Managed Grafana instance."
}

output "id" {
  value = azurerm_dashboard_grafana.grafana.id
  description = "Specifies the resource id of the Azure Managed Grafana instance."
}
output "grafana_url" {
  value = azurerm_dashboard_grafana.grafana.endpoint
  description = "Specifies the URL of the Azure Managed Grafana instance."
}