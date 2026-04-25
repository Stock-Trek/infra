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

variable "role-update" {
  description = "Role name for updating the lambda"
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

variable "package-type" {
  description = "One of [Zip, Image]"
  type        = string
  validation {
    condition     = (var.package-type == "Zip") || (var.package-type == "Image" && var.image != null)
    error_message = "package-type must be one of [Zip, Image]. If package-type is Image, then image must not be null"
  }
}

variable "env-vars" {
  type    = map(string)
  default = {}
}

variable "zip" {
  description = "Zip lambdas, cannot be used with image"
  type = object({
    handler = string
    runtime = string
  })
  default = {
    handler = "bootstrap"
    runtime = "provided.al2023"
  }
}

variable "image" {
  description = "Image lambdas, cannot be used with zip"
  type = object({
    ecr-repository-arn = string
    repository-url     = string
    image-tag          = string
  })
  default = {
    ecr-repository-arn = "Missing ecr-repository-arn"
    image-tag          = "Missing image-tag"
    repository-url     = "Missing repository-url"
  }
}

variable "public-access-cors-bare-domain" {
  description = "Bare domain"
  type        = string
  nullable    = true
  default     = null
}
