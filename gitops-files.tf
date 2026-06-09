# Create the root/top-level kustomization.yaml in the GitOps repository
resource "github_repository_file" "root_kustomization" {
  repository          = var.git.repository
  branch              = var.git.reference
  file                = "${var.flux.parent_path}/kustomization.yaml"
  commit_message      = "Add root GitOps kustomization"
  overwrite_on_create = true

  content = file("${path.module}/templates/top-level/kustomization.yaml.tftpl")
  ### Lav evt om til temnplatefil så der kan være placeholders i manifestet
}

# Create ArgoCD namespace
resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = var.argocd.k8s_namespace
  }
}

# Create the ArgoCD Kustomize configuration in the GitOps repository
resource "github_repository_file" "argocd_kustomization" {
  repository          = var.git.repository
  branch              = var.git.reference
  file                = "${var.flux.parent_path}/argocd/kustomization.yaml"
  commit_message      = "Add ArgoCD kustomization"
  overwrite_on_create = true

  content = templatefile("${path.module}/templates/argocd/kustomization.yaml.tftpl",
    {
      version = var.argocd.version
  })
  ### Skal der evt fyldes noget ind i templatefilen?

  depends_on = [
    kubernetes_namespace_v1.argocd
  ]
}

# Create the Flux Kustomization resource for reconciling the ArgoCD manifests
resource "github_repository_file" "flux_argocd_kustomization" {
  repository          = var.git.repository
  branch              = var.git.reference
  file                = "${var.flux.parent_path}/argocd-kustomization.yaml"
  commit_message      = "Add Flux sync for ArgoCD"
  overwrite_on_create = true

  content = templatefile(
    "${path.module}/templates/fluxcd/argocd-kustomization.yaml.tftpl",
    {
      namespace     = var.flux.k8s_namespace
      interval      = var.flux.reconciliation_interval
      path          = "${var.flux.parent_path}/argocd"
      git_repo_path = var.flux.repo_path
      timeout       = var.flux.timeout
    }
  )

  depends_on = [
    github_repository_file.argocd_kustomization
  ]
}

# Create repository url as a local
locals {
  repository_url = "https://github.com/${var.git.owner}/${var.git.repository}.git"
}

# Create the Flux Kustomization resource for installing argocd app-of-platform
resource "github_repository_file" "app_of_platform" {
  repository = var.git.repository
  branch     = var.git.reference
  file       = "${var.flux.parent_path}/argocd/app-of-platform.yaml"

  content = templatefile(
    "${path.module}/templates/argocd/app-of-platform.yaml.tftpl",
    {
      path     = "${var.argocd.parent_path}/platform"
      repo_url = local.repository_url
      revision = var.git.reference
    }
  )
}

# Create the Flux Kustomization resource for installing argocd app-of-projects
resource "github_repository_file" "app_of_projects" {
  repository = var.git.repository
  branch     = var.git.reference
  file       = "${var.flux.parent_path}/argocd/app-of-projects.yaml"

  content = templatefile(
    "${path.module}/templates/argocd/app-of-projects.yaml.tftpl",
    {
      path     = "${var.argocd.parent_path}/projects"
      repo_url = local.repository_url
      revision = var.git.reference
    }
  )
}

# Create folder for platform-applications with a readme file
resource "github_repository_file" "platform_readme" {
  repository          = var.git.repository
  branch              = var.git.reference
  file                = "${var.argocd.parent_path}/platform/README.md"
  commit_message      = "Create platform directory"
  overwrite_on_create = true

  content = <<-EOT
    # Platform Applications

    ArgoCD monitors this directory and automatically deploys platform applications.
    EOT
}

# Create folder for projects-applications with a readme file
resource "github_repository_file" "projects_readme" {
  repository          = var.git.repository
  branch              = var.git.reference
  file                = "${var.argocd.parent_path}/projects/README.md"
  commit_message      = "Create projects directory"
  overwrite_on_create = true

  content = <<-EOT
    # Project Applications

    ArgoCD monitors this directory and automatically deploys project applications.
    EOT
}
