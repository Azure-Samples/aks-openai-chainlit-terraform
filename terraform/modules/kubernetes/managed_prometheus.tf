# Apply the ama-metrics-settings-configmap to your cluster.check 
# For more information on how to apply a configmap, check out the documentation.
# - https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/prometheus-metrics-scrape-configuration
# - https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/prometheus-metrics-scrape-validate#apply-config-file
# - https://github.com/Azure/prometheus-collector/blob/main/otelcollector/configmaps/ama-metrics-prometheus-config-configmap.yaml
resource "kubectl_manifest" "ama_metrics_prometheus_config_configmap" {
  yaml_body = file("${path.module}/yaml/ama-metrics-prometheus-config-configmap.yaml")
}

# Apply the ama-metrics-settings-configmap to your cluster.
resource "kubectl_manifest" "ama_metrics_settings_configmap" {
  yaml_body = file("${path.module}/yaml/ama-metrics-settings-configmap.yaml")
}