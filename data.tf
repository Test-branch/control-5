# data "github_repositories" "repos" {
#   query = "org:${var.github_organization}"
# }

data "github_repository" "default_branch" {
  for_each = toset(data.github_repositories.repos.names)
  name     = each.value
}

data "github_repositories" "repos" {
  query = "control-*"  # Replace with your prefix
}