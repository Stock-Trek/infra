variable "name" {
  description = "Table name"
  type        = string
}

variable "attributes" {
  description = "Map of table attribute names to types. Each type must be one of [S, N, B]"
  type        = map(string)

  validation {
    condition = alltrue([
      for type in values(var.attributes) :
      contains(["S", "N", "B"], type)
    ])
    error_message = "Each attribute type must be one of [S, N, B]."
  }
}

variable "hash-key" {
  description = "Partition key attribute name. Must be one of the attribute keys"
  type        = string

  validation {
    condition     = contains(keys(var.attributes), var.hash-key)
    error_message = "hash-key must be one of the attribute keys."
  }
}

variable "range-key" {
  description = "Optional sort key attribute name. Must be one of the attribute keys when set"
  type        = string
  nullable    = true
  default     = null

  validation {
    condition = (
      var.range-key == null ||
      try(contains(keys(var.attributes), var.range-key), false)
    )
    error_message = "range-key must be null or one of the attribute keys."
  }
}

variable "global-secondary-indexes" {
  description = "Map of global secondary index names to their configuration"
  type = map(object({
    hash-key           = string
    range-key          = optional(string)
    projection-type    = string
    non-key-attributes = optional(list(string), [])
    read-capacity      = optional(number)
    write-capacity     = optional(number)
  }))
  default = {}

  validation {
    condition = alltrue([
      for index in values(var.global-secondary-indexes) :
      contains(keys(var.attributes), index.hash-key)
    ])
    error_message = "Each global secondary index hash-key must be one of the attribute keys."
  }

  validation {
    condition = alltrue([
      for index in values(var.global-secondary-indexes) :
      index.range-key == null || try(contains(keys(var.attributes), index.range-key), false)
    ])
    error_message = "Each global secondary index range-key must be null or one of the attribute keys."
  }

  validation {
    condition = alltrue([
      for index in values(var.global-secondary-indexes) :
      contains(["ALL", "INCLUDE", "KEYS_ONLY"], index.projection-type)
    ])
    error_message = "Each global secondary index projection-type must be one of [ALL, INCLUDE, KEYS_ONLY]."
  }

  validation {
    condition = alltrue([
      for index in values(var.global-secondary-indexes) :
      index.projection-type != "INCLUDE" || length(index.non-key-attributes) > 0
    ])
    error_message = "Each global secondary index with projection-type INCLUDE must set at least one non-key-attribute."
  }
}

variable "billing" {
  description = "Billing configuration. read-capacity and write-capacity are only valid when mode is PROVISIONED"
  type = object({
    mode           = string
    read-capacity  = optional(number)
    write-capacity = optional(number)
  })
  default = { mode = "PAY_PER_REQUEST" }

  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing.mode)
    error_message = "mode must be one of ['PAY_PER_REQUEST', 'PROVISIONED']."
  }
}

variable "stream-view-type" {
  description = "Stream view type. Streams are enabled when set. One of [KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES]"
  type        = string
  nullable    = true
  default     = null

  validation {
    condition = var.stream-view-type == null || try(contains([
      "KEYS_ONLY",
      "NEW_IMAGE",
      "OLD_IMAGE",
      "NEW_AND_OLD_IMAGES"
    ], var.stream-view-type), false)
    error_message = "stream-view-type must be one of [null, KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES]."
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
