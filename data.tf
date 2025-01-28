# data "github_repositories" "repos" {
#   query = "org:${var.github_organization}"
# }

data "github_repositories" "repos" {
  query = "org:${var.github_organization} ${var.repo_prefix}*"
}

# data "github_repository" "default_branch" {
#   for_each = toset(data.github_repositories.repos.names)
#   name     = each.value
# }

