variable "name" {
  description = "ECR name"
  type        = string
}

variable "mutability-exclusion-filter" {
  description = "Image name that can be mutable"
  type        = string
  nullable    = true
}

variable "github-account" {
  description = "GitHub account name"
  type        = string
}

variable "github-oidc-arn" {
  description = "OIDC provider arn for GitHub"
  type        = string
}

variable "role-update" {
  description = "Role name for pushing/updating images in the repository"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
