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

variable "content-based-deduplication" {
  description = "Enable content-based deduplication (FIFO queues only)"
  type        = bool
  default     = false

  validation {
    condition     = !var.content-based-deduplication || var.fifo
    error_message = "content-based-deduplication can only be enabled for FIFO queues"
  }
}

variable "visibility-timeout" {
  description = "Visibility timeout in seconds"
  type        = number
  default     = 30
}

variable "message-retention" {
  description = "Message retention period in seconds"
  type        = number
  default     = 345600
}

variable "delay" {
  description = "Delivery delay in seconds"
  type        = number
  default     = 0
}

variable "receive-wait" {
  description = "Long polling wait time in seconds"
  type        = number
  default     = 20
}

variable "max-message-size" {
  description = "Maximum message size in bytes"
  type        = number
  default     = 262144
}

variable "kms-master-key-id" {
  description = "KMS key id for SSE-KMS, uses SSE-SQS when null"
  type        = string
  nullable    = true
  default     = null
}

variable "dead-letter" {
  description = "Optional dead letter queue configuration"
  type = object({
    max-receive-count = number
  })
  nullable = true
  default  = null
}
