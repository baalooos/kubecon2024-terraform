// Helm Chart that will be used to create External Secret Resources
resource "helm_release" "external_secret" {
  count = var.kube_param.deploy_external_secret ? 1 : 0
  name  = "external-secret"

  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = var.kube_param.external_secret_version
  namespace        = "external-secrets"
  create_namespace = true
  set {
    name  = "installCRDs"
    value = "true"
  }
}
