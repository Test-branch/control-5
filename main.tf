# resource "github_branch_protection" "protection" {
#   for_each = toset(data.github_repositories.repos.names)

resource "github_branch_protection" "default" {
  for_each = { for repo in data.github_repositories.repos.names : repo => repo }

  repository_id = each.value

  # Get the default branch for each repository
  pattern = data.github_repository.default_branch[each.value].default_branch

#  pattern       = data.github_repository.default_branch.default_branch

  enforce_admins      = true
  allows_force_pushes = false
  #allows_deletions    = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 2
  }

  required_status_checks {
    strict   = true
    contexts = []
  }

}
