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

variable "role_update" {
  description = "Role name for updating the lambda"
  type        = string
}

variable "github_oidc_arn" {
  description = "OIDC provider arn for GitHub"
  type        = string
}

variable "github_account" {
  description = "GitHub account name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}

variable "package_type" {
  description = "One of [Zip, Image]"
  type        = string
  validation {
    condition     = (var.package_type == "Zip") || (var.package_type == "Image" && var.image != null)
    error_message = "package-type must be one of [Zip, Image]. If package-type is Image, then image must not be null"
  }
}

variable "env_vars" {
  type    = map(string)
  default = {}
}

variable "reserved_concurrent_executions" {
  description = "Function-level reserved concurrency. Set to a positive number to cap concurrent executions."
  type        = number
  default     = 5

  validation {
    condition     = var.reserved_concurrent_executions >= 0
    error_message = "reserved_concurrent_executions must be greater than or equal to 0."
  }
}

variable "subnet_ids" {
  description = "Private subnet IDs to run the Lambda in. When empty, the Lambda runs outside a VPC."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Security group IDs applied to the Lambda when running inside a VPC"
  type        = list(string)
  default     = []
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
    ecr_repository_arn = string
    repository_url     = string
    image_tag          = string
  })
  default = {
    ecr_repository_arn = "Missing ecr-repository-arn"
    image_tag          = "Missing image-tag"
    repository_url     = "Missing repository-url"
  }
}

variable "public_access_cors_bare_domain" {
  description = "Bare domain"
  type        = string
  nullable    = true
  default     = null
}
