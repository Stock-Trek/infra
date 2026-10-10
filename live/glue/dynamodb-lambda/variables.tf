variable "stream-arn" {
  description = "DynamoDB stream arn to consume records from"
  type        = string
}

variable "lambda-arn" {
  description = "ARN of the Lambda function to invoke with DynamoDB stream records"
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

variable "bisect-batch-on-function-error" {
  description = "Whether to split the batch in two and retry when the function returns an error"
  type        = bool
  default     = false
}

variable "maximum-retry-attempts" {
  description = "Maximum number of times to retry a failed batch before sending records to the on-failure destination"
  type        = number
  nullable    = true
  default     = null
}

variable "maximum-record-age-in-seconds" {
  description = "Maximum age in seconds of a record before it is sent to the on-failure destination"
  type        = number
  nullable    = true
  default     = null
}
