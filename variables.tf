variable "flux" {
  type = object({
    version = string
  })
}

variable "github_secret" {
  description = "GitHub app secret"
  type = string
  sensitive = true
  nullable = false
}
