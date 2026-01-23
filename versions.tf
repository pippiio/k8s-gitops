terraform {
  required_version = ">= 1.14"

  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~>1.7"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>3"
    }
  }
}
