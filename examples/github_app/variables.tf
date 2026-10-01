variable "owner" {
  type = string
}

variable "repository" {
  type = string
}

variable "reference" {
  type    = string
  default = "main"
}

variable "auth" {
  type = object({
    flux_app_id              = string
    flux_app_installation_id = string

    gpg_key_id     = string
    gpg_key_ring   = string
    gpg_passphrase = string

    author_name  = string
    author_email = string

  })
  sensitive = true
}

variable "flux_app_pem_file" {
  type = string
}

variable "github_private_key" {
  type = string
}
