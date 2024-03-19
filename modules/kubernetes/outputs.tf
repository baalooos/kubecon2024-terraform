output "cluster-status" {
  value = scaleway_k8s_cluster.k8s_cluster.status
}

output "cluster-upgrade" {
  value = scaleway_k8s_cluster.k8s_cluster.upgrade_available
}

output "node-0-min-size" {
  value = scaleway_k8s_pool.k8s_pool_0.min_size
}

output "node-0-max-size" {
  value = scaleway_k8s_pool.k8s_pool_0.max_size
}

output "node-1-min-size" {
  value = [for pool in scaleway_k8s_pool.k8s_pool_1 : pool.min_size]
}

output "node-1-max-size" {
  value = [for pool in scaleway_k8s_pool.k8s_pool_1 : pool.max_size]
}
