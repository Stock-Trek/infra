variable "prefix" {
  description = "Prefix path in parameter store to manage access for"
  type        = string
}

variable "repo_name" {
  description = "Repository name to grant write access to (master branch only)"
  type        = string
}

variable "writer_role_name" {
  description = "Role name to grant write access to"
  type        = string
}

variable "lambda_role_name" {
  description = "Lambda role name to grant read access to"
  type        = string
}

variable "github_account" {
  description = "GitHub account name"
  type        = string
}

variable "github_oidc_arn" {
  description = "OIDC provider arn for GitHub"
  type        = string
}
