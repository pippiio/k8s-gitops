provider "kubernetes" {}

module "k8s-gitops" {
  source = "git@github.com:pippi.io/k8s-gitops?ref=HEAD"

}
