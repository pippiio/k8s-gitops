module "debug" {
  source = "../.."
  flux = {
    version    = "2.12.4"
  }
  github_secret = "hej"
}

provider "kubernetes" {
  
  config_path    = "adeo-config.yaml"
  config_context = "admin@adeo"
}

data "kubernetes_all_namespaces" "allns" {}

output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}

provider "flux" {
  kubernetes = {
    config_path = "adeo-config.yaml"
  }
}

provider "helm" {
  kubernetes = {
    config_path = "adeo-config.yaml"
  }
}

