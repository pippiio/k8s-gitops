
module "flux" {
  source = "git@github.com:pippiio/k8s-gitops.git?ref=main"

  git = {
    owner      = var.owner
    repository = var.repository
    reference  = var.reference
  }

  flux = {
    version = "v2.8.8"

    githubAppID             = var.auth.flux_app_id
    githubAppInstallationID = var.auth.flux_app_installation_id
    githubAppPrivateKey     = var.flux_app_pem_file
  }
  argocd = {
    version = "v3.1.0"
  }
}
