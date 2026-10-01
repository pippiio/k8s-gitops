variable "git" {
  description = <<EOF
Git repository configuration:
  owner:
    Git user or organization that owns the repository.

  repository:
    Name of the Git repository used for GitOps manifests.

  reference:
    Git reference used by Flux and ArgoCD.
    Can be a branch, tag, or commit SHA.

  username:
    Username used for Git authentication.

  password:
    Password or token used for Git authentication.
    This will typically be a Personal Access Token (PAT).
EOF

  type = object({
    owner      = string
    repository = string
    reference  = optional(string, "main")
    username   = string
    password   = string
  })

  sensitive = true
  nullable  = false
}

variable "flux" {
  description = <<EOF
Flux configuration:
  k8s_namespace:
    Namespace where Flux is installed.

  parent_path:
    Path in the Git repository where Flux manifests are stored.

  git_reference:
    Git reference used by Flux when reconciling resources.
    Can be a branch, tag, or commit SHA.

  version:
    Version of Flux to install.

  repo_path:
    Name of the Flux GitRepository resource referenced by Kustomizations.

  reconciliation_interval:
    Reconciliation interval for Flux Kustomizations.

  timeout:
    Maximum time Flux waits for a reconciliation to complete before failing.
EOF

  type = object({
    k8s_namespace           = optional(string, "flux-system")
    parent_path             = optional(string, "gitops/fluxcd")
    git_reference           = optional(string, "main")
    version                 = string
    repo_path               = optional(string, "flux-system")
    reconciliation_interval = optional(string, "1m")
    timeout                 = optional(string, "5m")
  })

  nullable = false
}

variable "argocd" {
  description = <<EOF
ArgoCD configuration:
  k8s_namespace:
    Namespace where ArgoCD is installed.

  parent_path:
    Path in the Git repository where ArgoCD manifests and applications are stored.

  git_reference:
    Git reference used by ArgoCD applications.
    Can be a branch, tag, or commit SHA.

  version:
    Version of ArgoCD to install.
EOF

  type = object({
    k8s_namespace = optional(string, "argocd")
    parent_path   = optional(string, "gitops/argocd")
    git_reference = optional(string, "main")
    version       = string
  })

  nullable = false
}
