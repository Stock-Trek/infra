variable "name" {
  description = "Table name"
  type        = string
}

variable "hash-key" {
  description = "Partition key attribute name"
  type        = string
}

variable "hash-key-type" {
  description = "Partition key attribute type. One of [S, N, B]"
  type        = string
  default     = "S"

  validation {
    condition     = contains(["S", "N", "B"], var.hash-key-type)
    error_message = "hash-key-type must be one of [S, N, B]."
  }
}

variable "range-key" {
  description = "Optional sort key attribute name"
  type        = string
  nullable    = true
  default     = null
}

variable "range-key-type" {
  description = "Sort key attribute type. One of [S, N, B]"
  type        = string
  nullable    = true
  default     = "S"

  validation {
    condition     = var.range-key-type == null || contains(["S", "N", "B"], var.range-key-type)
    error_message = "range-key-type must be one of [null, S, N, B]."
  }
}

variable "billing-mode" {
  description = "Billing mode. One of [PAY_PER_REQUEST, PROVISIONED]"
  type        = string
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing-mode)
    error_message = "billing-mode must be one of [PAY_PER_REQUEST, PROVISIONED]."
  }
}

variable "read-capacity" {
  description = "Read capacity units. Only valid when billing-mode is PROVISIONED"
  type        = number
  nullable    = true
  default     = null
}

variable "write-capacity" {
  description = "Write capacity units. Only valid when billing-mode is PROVISIONED"
  type        = number
  nullable    = true
  default     = null
}

variable "stream-enabled" {
  description = "Whether to enable DynamoDB streams for the table"
  type        = bool
  default     = false
}

variable "stream-view-type" {
  description = "Stream view type. One of [KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES]"
  type        = string
  nullable    = true
  default     = null

  validation {
    condition = var.stream-view-type == null || contains([
      "KEYS_ONLY",
      "NEW_IMAGE",
      "OLD_IMAGE",
      "NEW_AND_OLD_IMAGES"
    ], var.stream-view-type)
    error_message = "stream-view-type must be one of [null, KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES]."
  }

  validation {
    condition     = var.stream-enabled ? var.stream-view-type != null : var.stream-view-type == null
    error_message = "stream-view-type must be set when stream-enabled is true, and null when stream-enabled is false."
  }
}

variable "ttl-attribute" {
  description = "Optional attribute name to use for time to live"
  type        = string
  nullable    = true
  default     = null
}

variable "point-in-time-recovery" {
  description = "Whether to enable point in time recovery"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
