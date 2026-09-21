variable "name" {
  description = "Queue name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}

variable "fifo" {
  description = "Whether to create a FIFO queue"
  type        = bool
  default     = false
}

variable "dead-letter" {
  description = "Optional dead letter queue configuration"
  type = object({
    max-receive-count = number
  })
  nullable = true
  default  = null
}
