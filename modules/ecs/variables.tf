variable "name" {
  description = "ECS cluster, task definition and log group name"
  type        = string
}

variable "cpu" {
  description = "Fargate task CPU units"
  type        = number
  default     = 2048
}

variable "memory" {
  description = "Fargate task memory (MB)"
  type        = number
  default     = 4096
}

variable "image" {
  description = "Container image configuration"
  type = object({
    repository_url = string
    image_tag      = string
  })
}

variable "subnet_ids" {
  description = "Private subnet ids to run tasks in"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "subnet_ids must contain at least one subnet."
  }
}

variable "security_group_ids" {
  description = "Security group ids to attach to tasks"
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "security_group_ids must contain at least one security group."
  }
}

variable "environment" {
  description = "Environment variables to pass to the container"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
