variable "name" {
  description = "Table name"
  type        = string
}

variable "attributes" {
  description = "Map of table attributes. Each attribute has a key (attribute name) and a data_type. data_type must be one of [S, N, B]"
  type = map(object({
    key       = string
    data_type = string
  }))

  validation {
    condition = alltrue([
      for attribute in values(var.attributes) :
      contains(["S", "N", "B"], attribute.data_type)
    ])
    error_message = "Each attribute data_type must be one of [S, N, B]."
  }
}

variable "hash-key" {
  description = "Partition key attribute name. Must be one of the attribute keys"
  type        = string

  validation {
    condition     = contains([for attribute in values(var.attributes) : attribute.key], var.hash-key)
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
      contains([for attribute in values(var.attributes) : attribute.key], var.range-key)
    )
    error_message = "range-key must be null or one of the attribute keys."
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
    condition = var.stream-view-type == null || contains([
      "KEYS_ONLY",
      "NEW_IMAGE",
      "OLD_IMAGE",
      "NEW_AND_OLD_IMAGES"
    ], var.stream-view-type)
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
