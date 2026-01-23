variable "flux" {
  type = object({
    version = string
  })
}

variable "github_app_private_key" {
  description = "GitHub app private key"
  type        = string
  sensitive   = true
  nullable    = false
}

variable "github" {
  type = object({
    app_id              = string
    app_installation_id = string
  })
}
