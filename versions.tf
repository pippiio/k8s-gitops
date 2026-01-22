terraform {
  required_version = ">= 1.14"

  required_providers {
    flux = {
      source = "fluxcd/flux"
      version = "1.7.6"
    }
  }
}
