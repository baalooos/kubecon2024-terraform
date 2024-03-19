resource "time_sleep" "wait_for_cluster" { # wait 1 minute for cluster to stabilize (CNI, etc...)
  depends_on      = [null_resource.kubeconfig]
  create_duration = "60s"
}

resource "kubernetes_namespace" "external-secrets" {
  metadata {
    annotations = {
      name = "external-secrets"
    }

    name = "external-secrets"
  }
}

// Create full access group
resource "scaleway_iam_group" "external_secrets" {
  name        = "${var.env_name}-external-secrets"
  description = "This is full access for external secrets"
  tags        = var.tags
}

// Create full access policy
resource "scaleway_iam_policy" "policy_full_access" {
  name     = "${var.env_name}-external-secrets"
  group_id = scaleway_iam_group.external_secrets.id
  rule {
    project_ids = [var.project_id]
    // The right we give
    permission_set_names = ["AllProductsFullAccess"]
  }
  tags = var.tags
}

resource "scaleway_iam_application" "external-secrets" {
  name = "${var.env_name}-external-secrets"
}

resource "scaleway_iam_api_key" "external-secrets" {
  application_id = scaleway_iam_application.external-secrets.id
  description    = "a description"
}

resource "scaleway_iam_group_membership" "external_secrets" {
  group_id       = scaleway_iam_group.external_secrets.id
  application_id = scaleway_iam_application.external-secrets.id
}

resource "kubernetes_secret" "external-secret" {
  depends_on = [kubernetes_namespace.external-secrets, scaleway_iam_api_key.external-secrets]
  metadata {
    name      = "very-secret"
    namespace = "external-secrets"
  }

  data = {
    region            = var.region
    access-key        = scaleway_iam_api_key.external-secrets.access_key
    secret-access-key = scaleway_iam_api_key.external-secrets.secret_key
  }
}
