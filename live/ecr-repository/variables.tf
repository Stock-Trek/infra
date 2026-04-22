variable "name" {
  description = "ECR name"
  type        = string
}

variable "mutability-exclusion-filter" {
  description = "Image name that can be mutable"
  type        = string
  nullable    = true
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
