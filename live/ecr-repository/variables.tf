variable "name" {
  description = "ECR name"
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

variable "role_update" {
  description = "Role name for pushing/updating images in the repository"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
