variable "env_name" {}
variable "tags" {}
variable "main_zone" {}
variable "backup_zone" {}

variable project_id {}

// Id of the pn
variable "private_network" {}

variable "kube_param" {}

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

variable "region" {
  type = string
}
