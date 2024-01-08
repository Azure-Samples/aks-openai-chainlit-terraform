resource "kubectl_manifest" "nginx_cluster_issuer" {
  yaml_body = <<-EOF
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: letsencrypt-nginx
      namespace: kube-system
    spec:
      acme:
        server: https://acme-v02.api.letsencrypt.org/directory
        email: ${var.email}
        privateKeySecretRef:
          name: letsencrypt-nginx
        solvers:
        - http01:
            ingress:
              class: nginx
              podTemplate:
                spec:
                  nodeSelector:
                    "kubernetes.io/os": linux
    EOF

  depends_on = [helm_release.cert_manager]
}

resource "kubectl_manifest" "managed_nginx_cluster_issuer" {
  yaml_body = <<-EOF
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: letsencrypt-webapprouting
      namespace: kube-system
    spec:
      acme:
        server: https://acme-v02.api.letsencrypt.org/directory
        email: ${var.email}
        privateKeySecretRef:
          name: letsencrypt-webapprouting
        solvers:
        - http01:
            ingress:
              class: webapprouting.kubernetes.azure.com
              podTemplate:
                spec:
                  nodeSelector:
                    "kubernetes.io/os": linux
    EOF

  depends_on = [helm_release.cert_manager]
}