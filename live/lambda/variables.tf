variable "name" {
  description = "Lambda name"
  type        = string
}

variable "memory" {
  description = "Lambda memory (MB)"
  type        = number
}

variable "timeout" {
  description = "Lambda timeout (seconds)"
  type        = number
}

variable "role-update-code" {
  description = "Role name for updating lambda code"
  type        = string
}

variable "github-oidc-arn" {
  description = "OIDC provider arn for GitHub"
  type        = string
}

variable "github-account" {
  description = "GitHub account name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}

variable "public-access-cors-bare-domain" {
  description = "Bare domain"
  type        = string
  nullable    = true
  default     = null
}
