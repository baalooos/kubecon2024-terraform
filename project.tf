resource "scaleway_cockpit" "cockpit" {
  plan       = var.kubecon2024_core.cockpit_plan
}
