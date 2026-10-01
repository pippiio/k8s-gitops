variable "github_token" {
  type      = string
  sensitive = true
}

variable "owner" {
  type = string
}

variable "repository" {
  type = string
}

variable "username" {
  type = string
}

variable "reference" {
  type    = string
  default = "main"
}
