<!-- BEGIN_TF_DOCS -->
# pippi.io/k8s-gitops

Kubernetes GitOps module powered by FluxCD and ArgoCD

# Examples

```hcl
provider "kubernetes" {}

module "k8s-gitops" {
  source = "git@github.com:pippi.io/k8s-gitops?ref=HEAD"

}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.14 |











<!-- END_TF_DOCS -->