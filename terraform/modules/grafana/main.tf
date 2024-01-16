resource "azurerm_dashboard_grafana" "grafana" {
  name                                   = var.name
  resource_group_name                    = var.resource_group_name
  location                               = var.location
  api_key_enabled                        = var.api_key_enabled
  auto_generated_domain_name_label_scope = var.auto_generated_domain_name_label_scope
  deterministic_outbound_ip_enabled      = var.deterministic_outbound_ip_enabled
  public_network_access_enabled          = var.public_network_access_enabled
  sku                                    = var.sku
  zone_redundancy_enabled                = var.zone_redundancy_enabled
  tags                                   = var.tags

  identity {
    type = "SystemAssigned"
  }
  azure_monitor_workspace_integrations {
    resource_id = var.azure_monitor_workspace_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

// Assign the Monitoring Reader role to the Azure Managed Grafana system-assigned managed identity at the workspace scope
resource "azurerm_role_assignment" "grafana" {
  scope                =  var.azure_monitor_workspace_id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.grafana.identity[0].principal_id
}

# Add role assignment to Grafana so an admin user can log in
resource "azurerm_role_assignment" "grafana_admin" {
  scope                = azurerm_dashboard_grafana.grafana.id
  role_definition_name = "Grafana Admin"
  principal_id         = var.admin_group_object_id
}