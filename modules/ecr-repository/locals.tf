locals {
  github_repo_ref = var.github_repo_id == null ? var.github_repo : "${var.github_repo}@${var.github_repo_id}"
  github_subject  = "repo:${var.github_account}@${var.github_account_id}/${local.github_repo_ref}"

  remove_untagged = {
    rules = [
      {
        rulePriority = 1
        description  = "Keep at most 1 untagged image"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 1
        }
        action = {
          type = "expire"
        }
      }
    ]
  }
}
