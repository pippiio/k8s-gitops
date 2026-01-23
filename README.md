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
| flux | ~>1.7 |
| helm | ~>3 |
| kubernetes | ~>3 |

## Providers

| Name | Version |
|------|---------|
| helm | 3.1.1 |
| kubernetes | 3.0.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| flux | n/a | <pre>object({<br/>    version = string<br/>  })</pre> | n/a | yes |
| github | n/a | <pre>object({<br/>    app_id              = string<br/>    app_installation_id = string<br/>  })</pre> | n/a | yes |
| github\_app\_private\_key | GitHub app private key | `string` | n/a | yes |



## Resources

| Name | Type |
|------|------|
| [helm_release.flux2](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace_v1.flux_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_secret_v1.githubapp-secret-flux](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |



<!-- END_TF_DOCS -->