module "debug" {
  source = "../.."
}

provider "kubernetes" {
  config_path    = "adeo-config.yaml"
  config_context = "admin@adeo"
}

data "kubernetes_all_namespaces" "allns" {}

output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}
