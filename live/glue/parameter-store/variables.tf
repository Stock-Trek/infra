variable "prefix" {
  description = "Prefix path in parameter store to manage access for"
  type        = string
}

variable "repo-name" {
  description = "Repository name to grant write access to (master branch only)"
  type        = string
}

variable "writer-role-name" {
  description = "Role name to grant write access to"
  type        = string
}

variable "lambda-role-name" {
  description = "Lambda role name to grant read access to"
  type        = string
}

variable "github-account" {
  description = "GitHub account name"
  type        = string
}

variable "github-oidc-arn" {
  description = "OIDC provider arn for GitHub"
  type        = string
}
