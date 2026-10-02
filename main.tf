# Create the namespace for Flux
resource "kubernetes_namespace_v1" "flux_system" {
  metadata {
    name = var.flux.k8s_namespace
  }
}

# Create ArgoCD namespace
resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = var.argocd.k8s_namespace
  }
}

resource "kubernetes_secret_v1" "this" {
  metadata {
    name      = "flux-github"
    namespace = kubernetes_namespace_v1.flux_system.metadata[0].name
  }

  data_wo_revision = 1
  data_wo = {
    "githubAppID"             = var.flux.githubAppID
    "githubAppInstallationID" = var.flux.githubAppInstallationID
    "githubAppPrivateKey"     = var.flux.githubAppPrivateKey
  }
}


# Bootstrap FluxCD in the cluster using the Git repository as the source of truth
resource "flux_bootstrap_git" "this" {
  depends_on = [
    kubernetes_namespace_v1.flux_system
  ]

  path                    = var.flux.parent_path
  embedded_manifests      = true
  disable_secret_creation = true
  secret_name             = kubernetes_secret_v1.this.metadata[0].name
  kustomization_override = templatefile(
    "${path.module}/flux-kustomization-patch.yaml",
    {
      owner      = var.git.owner
      repository = var.git.repository
  })
  version = var.flux.version
}
