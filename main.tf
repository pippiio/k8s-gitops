/**
 * # pippi.io/k8s-gitops
 *
 * Kubernetes GitOps module powered by FluxCD and ArgoCD
 *
 */

provider "kubernetes" {
  config_path    = "adeo-config.yaml"
  config_context = "admin@adeo"
}

provider "flux" {
  kubernetes = {
    config_path    = "adeo-config.yaml"
  }
}

resource "kubernetes_namespace_v1" "flux_system" {
  metadata {
    name = "flux-system"
  }
}

provider "helm" {
  kubernetes = {
    config_path = "adeo-config.yaml"
  }
}

resource "helm_release" "flux2" {
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2"
  version    = "2.12.4"

  name      = "flux2"
  namespace = "flux-system"

  depends_on = [kubernetes_namespace_v1.flux_system]
}
