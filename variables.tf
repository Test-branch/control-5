variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "github_organization" {
  description = "GitHub organization name"
  type        = string
}

variable "repo_prefix" {
  type = string
  default = "control"
}