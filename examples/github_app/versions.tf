terraform {
  required_version = ">= 1.14"

  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.8.7"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.1"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.12.1"
    }
  }
}


provider "flux" {
  kubernetes = {
    config_path = "../.kube/config"
  }

  git = {
    url    = "ssh://git@github.com/${var.owner}/${var.repository}.git"
    branch = var.reference

    gpg_key_id     = var.auth.gpg_key_id
    gpg_key_ring   = var.auth.gpg_key_ring
    gpg_passphrase = var.auth.gpg_passphrase

    author_name  = var.auth.author_name
    author_email = var.auth.author_email

    ssh = {
      username    = "git"
      private_key = var.github_private_key
    }
  }
}

provider "github" {
  owner = var.owner
  app_auth {
    id              = var.auth.flux_app_id
    installation_id = var.auth.flux_app_installation_id
    pem_file        = var.flux_app_pem_file
  }
}

provider "kubernetes" {
  config_path = "../.kube/config"
}

# Alternative provider setup using Talos module output
# provider "kubernetes" {
#   host                   = module.cluster.kubeconfig.host
#   cluster_ca_certificate = module.cluster.kubeconfig.cluster_ca_certificate
#   client_certificate     = module.cluster.kubeconfig.client_certificate
#   client_key             = module.cluster.kubeconfig.client_key
# }
