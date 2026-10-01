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
    config_path = "~/.kube/config"
  }

  git = {
    url    = "https://github.com/${var.owner}/${var.repository}.git"
    branch = var.reference

    http = {
      username = var.username
      password = var.github_token
    }
  }
}

provider "github" {
  owner = var.owner
  token = var.github_token
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Alternative provider setup using Talos module output
# provider "kubernetes" {
#   host                   = module.cluster.kubeconfig.host
#   cluster_ca_certificate = module.cluster.kubeconfig.cluster_ca_certificate
#   client_certificate     = module.cluster.kubeconfig.client_certificate
#   client_key             = module.cluster.kubeconfig.client_key
# }

module "flux" {
  source = "git::https://github.com/pippiio/k8s-gitops.git?ref=main"

  git = {
    owner      = var.owner
    repository = var.repository
    username   = var.username
    password   = var.github_token
  }

  flux = {
    version = "v2.8.8"
  }
  argocd = {
    version = "v3.1.0"
  }
}
