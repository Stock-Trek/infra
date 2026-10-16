locals {
  prefix          = trim(var.prefix, "/")
  github_repo_ref = "${var.github_repo}@${var.github_repo_id}"
  github_subject  = "repo:${var.github_account}@${var.github_account_id}/${local.github_repo_ref}"
}
