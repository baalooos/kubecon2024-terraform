module "kubernetes" {
  source = "./modules/kubernetes/"

  region     = var.kubecon2024_core.region
  env_name   = var.kubecon2024_core.env_name
  project_id = var.project_id
  kube_param = var.kubecon2024_kube

  private_network = scaleway_vpc_private_network.pn

  main_zone   = var.kubecon2024_core.main_zone
  backup_zone = var.kubecon2024_core.backup_zone
  tags        = var.tags

  github_org        = var.github_org
  github_repository = var.github_repository
  github_token      = var.github_token
}
