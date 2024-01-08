resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "${var.namespace}"
  }
}

resource "kubectl_manifest" "service_account" {
  yaml_body = <<-EOF
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      annotations:
        azure.workload.identity/client-id: ${var.workload_managed_identity_client_id}
        azure.workload.identity/tenant-id: ${var.tenant_id}
      labels:
        azure.workload.identity/use: "true"
      name: ${var.service_account_name}
      namespace: ${var.namespace}
    EOF

  depends_on = [kubernetes_namespace.namespace]
}