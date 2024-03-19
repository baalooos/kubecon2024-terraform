// Create the container registry
resource "scaleway_registry_namespace" "container-registry" {
  name        = "${var.kubecon2024_core.env_name}-container-registry"
  description = "Container registry for ${var.kubecon2024_core.env_name}"
  is_public   = false
}
