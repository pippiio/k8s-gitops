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



