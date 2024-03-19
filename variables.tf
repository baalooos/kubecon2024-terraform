// Variables for staging environment
// Common variables
variable "kubecon2024_core" {
  type = map(string)

  default = {
    project_id = "1b278a9d-c985-4c38-9c5e-95a61514f067"
    production = false
    //env name
    env_name = "kubecon"
    //conditional deployments
    region = "fr-par"
    // Main zone
    main_zone = "fr-par-1"
    // Backup zone
    backup_zone = "fr-par-2"

    deploy_db = false
    // Can be "free" or "premium"
    cockpit_plan = "free"
  }
}

variable "tags" {
  default = ["kubecon2024", "terraform", "iac"]
}

// Network variables
variable "kubecon2024_network" {
  type = map(string)

  default = {
    // CIDR to use, at least /22 for Kapsule
    network_private_cidr = "192.168.0.0/22"
    // Type of the Public Gateway
    network_pgw_type = "VPC-GW-S"
    // SSH bastion on Public Gateway
    network_pgw_enable_bastion = true
  }
}

// Kube Variables
variable "kubecon2024_kube" {
  type = map(string)

  default = {
    // Config for the cluster
    // Type of the control plane, can be "kapsule", "kapsule-dedicated-4", "kapsule-dedicated-8" or "kapsule-dedicated-16".
    cluster_type = "kapsule"
    // Kubernetes version
    kapsule_version = "1.28.2"
    // Warning modifying this will recreate the cluster
    cni = "cilium"

    // Config for the first pool
    // Instance type
    cluster_pool_0_node_type = "PLAY2-MICRO"
    // Disk size for node, in Go
    cluster_pool_0_disk_size = 20
    // Min number of instances
    cluster_pool_0_min_size = 2
    // Max number of instances
    cluster_pool_0_max_size = 4

    // Config for the second pool
    // Do we need a second pool
    deploy_backup_pool = false
    // Instance type
    cluster_pool_1_node_type = "PLAY2-NANO"
    // Disk size for node, in Go
    cluster_pool_1_disk_size = 20
    // Min number of instances
    cluster_pool_1_min_size = 1
    // Max number of instances
    cluster_pool_1_max_size = 4

    // Do we need cert manager
    deploy_cert_manager = true
    // Version for cert manager
    cert_manager_version = "v1.13.3"

    // Do we need external secret
    deploy_external_secret = true
    // Version for external secret
    external_secret_version = "v0.9.11"

    // Do we need ingress controller
    deploy_ingress_nginx = true

    // Ip to whitelist
    allowed_cidr = "['0.0.0.0/0']"
  }
}

// Flux
variable "github_token" {
  sensitive = true
  type      = string
}

variable "github_org" {
  type = string
}

variable "github_repository" {
  type = string
}
