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
    repository-url = string
    image-tag      = string
  })
}

variable "subnet-ids" {
  description = "Subnet ids to run tasks in"
  type        = list(string)
}

variable "security-group-ids" {
  description = "Security group ids to attach to tasks"
  type        = list(string)
}

variable "environment" {
  description = "Environment variables to pass to the container"
  type        = map(string)
  default     = {}
}

variable "log-retention-days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
