# Create the namespace for Flux
resource "kubernetes_namespace_v1" "flux_system" {
  metadata {
    name = var.flux.k8s_namespace
  }
}

# Bootstrap FluxCD in the cluster using the Git repository as the source of truth
resource "flux_bootstrap_git" "this" {
  depends_on = [
    kubernetes_namespace_v1.flux_system
  ]

  path               = var.flux.parent_path
  embedded_manifests = true
  version            = var.flux.version
}
