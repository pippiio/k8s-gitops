# Create the namespace for Flux
resource "kubernetes_namespace_v1" "flux_system" {
  metadata {
    name = var.flux.k8s_namespace
  }
}

# Create the GitRepository resource for Flux
resource "flux_bootstrap_git" "this" {
  depends_on = [
    kubernetes_namespace_v1.flux_system
  ]

  path               = var.flux.parent_path
  embedded_manifests = true
  version            = var.flux.version
}
