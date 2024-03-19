terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.34.0"
    }
  }

  // State storage
  backend "s3" {
    // Change this.
    bucket = "kubecon-demo-automation-2024"
    // Path in the S3 bucket
    key = "kubecon2024/dev/terraform.tfstate"
    // Region of the bucket
    region = "fr-par"
    // Change the endpoint if we change the region
    endpoints                  = { s3 = "https://s3.fr-par.scw.cloud" }
    skip_requesting_account_id = true
    // Credentials of the user to use
    //profile = "scaleway"
    // Needed for SCW
    skip_credentials_validation = true
    skip_region_validation      = true
  }

  // Terraform version
  required_version = ">= 1.6.1"
}

provider "scaleway" {
  // AZ we want to use
  zone = "fr-par-1"
  // Region we want to use
  region = "fr-par"
  // Replace with customer organization id
  organization_id = "79a00b89-8d66-471f-888a-758f48a8e039"
  project_id = "1b278a9d-c985-4c38-9c5e-95a61514f067"
  profile = "kubecon2024"
}
