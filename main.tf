/**
 * # pippi.io/k8s-gitops
 *
 * Kubernetes GitOps module powered by FluxCD and ArgoCD
 *
 */

resource "kubernetes_namespace_v1" "flux_system" {
  metadata {
    name = "flux-system"
  }
}

resource "helm_release" "flux2" {
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2"
  version    = var.flux.version

  name      = "flux2"
  namespace = "flux-system"

  depends_on = [kubernetes_namespace_v1.flux_system]
}

resource "kubernetes_secret_v1" "githubapp-secret-flux" {
  metadata {
    name      = "githubapp-secret"
    namespace = "flux-system"
  }

  data = {
    githubAppID             = var.github.app_id
    githubAppInstallationID = var.github.app_installation_id
    githubAppPrivateKey     = file("${path.module}/${var.github_app_private_key}")
  }

  type = "Opaque"
}
