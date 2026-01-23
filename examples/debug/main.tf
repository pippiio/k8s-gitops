module "debug" {
  source = "../.."
  flux = {
    version    = "2.12.4"
  }
  github_app_private_key = "adeo-config.yaml"
  github = {
    app_id = "123"
    app_installation_id = "456"
  }
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

