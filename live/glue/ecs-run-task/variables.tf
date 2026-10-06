variable "role" {
  description = "Role to attach ECS run task permission to"
  type        = string
}

variable "task-definition-arn" {
  description = "Task definition arn to allow running"
  type        = string
}

variable "execution-role-arn" {
  description = "Task execution role arn to pass to ECS"
  type        = string
}

variable "task-role-arn" {
  description = "Task role arn to pass to ECS"
  type        = string
}
