#!/bin/bash

# Get all repositories in the organization
  REPOS=$(curl -s -H "Authorization: token $PAT_TOKEN" \ https://api.github.com/orgs/$OWNER/repos | jq -r '.[].name')

# curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $PAT_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" \
#     https://api.github.com/orgs/Test-branch/repos | jq -r '.[].name'

for REPO in $REPOS; do
# Get the default branch name for each repository
  DEFAULT_BRANCH=$(curl -s -H "Authorization: token $PAT_TOKEN" \
    https://api.github.com/repos/$OWNER/$REPO | jq -r '.default_branch')

# Apply branch protection rules to the default branch
  curl -X PUT -H "Authorization: token $PAT_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/$OWNER/$REPO/branches/$DEFAULT_BRANCH/protection \
    -d '{
      "required_status_checks": null,
      "enforce_admins": true,
      "required_pull_request_reviews": {
      "dismiss_stale_reviews": false,
      "require_code_owner_reviews": true,
      "required_approving_review_count": 2
      },
      "restrictions": null,
      "required_linear_history": true,
      "allow_force_pushes": false,
      "allow_deletions": false
    }'