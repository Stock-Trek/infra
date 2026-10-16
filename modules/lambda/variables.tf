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

variable "alarm_actions" {
  description = "List of ARNs (for example an SNS topic) notified when an alarm changes state"
  type        = list(string)
  default     = []
}

variable "alarm_period" {
  description = "CloudWatch alarm evaluation period in seconds"
  type        = number
  default     = 300
}

variable "alarm_evaluation_periods" {
  description = "Number of periods an alarm must breach before it triggers"
  type        = number
  default     = 1
}

variable "error_alarm_threshold" {
  description = "Number of Lambda errors in a period before alarming"
  type        = number
  default     = 1
}

variable "throttle_alarm_threshold" {
  description = "Number of Lambda throttles in a period before alarming"
  type        = number
  default     = 1
}

variable "dead_letter_alarm_threshold" {
  description = "Number of visible messages on the Lambda dead letter queue before alarming"
  type        = number
  default     = 1
}
