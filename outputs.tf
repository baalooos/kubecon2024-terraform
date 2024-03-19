output "container_registry_endpoint" {
  description = "Endpoint for the container registry"
  value       = scaleway_registry_namespace.container-registry.endpoint
}

// Output for Network
output "gw_ip" {
  value = scaleway_vpc_public_gateway_ip.gw_ip.address
}

// Output for Kubernetes Module
output "cluster-status" {
  value = module.kubernetes.cluster-status
}

output "cluster-upgrade" {
  value = module.kubernetes.cluster-upgrade
}

output "node-0-min-size" {
  value = module.kubernetes.node-0-min-size
}

output "node-0-max-size" {
  value = module.kubernetes.node-0-max-size
}

output "node-1-min-size" {
  value = module.kubernetes.node-1-min-size
}

output "node-1-max-size" {
  value = module.kubernetes.node-1-max-size
}

