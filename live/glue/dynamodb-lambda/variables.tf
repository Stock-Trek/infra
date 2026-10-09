variable "stream-arn" {
  description = "DynamoDB stream arn to consume records from"
  type        = string
}

variable "lambda-name" {
  description = "Name of the Lambda function to invoke with DynamoDB stream records"
  type        = string
}

variable "role" {
  description = "Role to attach DynamoDB stream consume and DLQ write permissions to"
  type        = string
}

variable "dlq-bucket-arn" {
  description = "Bucket arn to use as the on-failure destination for unprocessed records"
  type        = string
}

variable "batch-size" {
  description = "Maximum number of records to retrieve per batch"
  type        = number
  default     = 100
}

variable "maximum-batching-window-in-seconds" {
  description = "Maximum amount of time in seconds to gather records before invoking the function"
  type        = number
  nullable    = true
  default     = null
}

variable "starting-position" {
  description = "Position in the stream where Lambda starts reading. One of [TRIM_HORIZON, LATEST]"
  type        = string
  default     = "LATEST"

  validation {
    condition     = contains(["TRIM_HORIZON", "LATEST"], var.starting-position)
    error_message = "starting-position must be one of [TRIM_HORIZON, LATEST]."
  }
}

variable "enabled" {
  description = "Whether the event source mapping is enabled"
  type        = bool
  default     = true
}
