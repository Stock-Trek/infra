variable "name" {
  description = "Bucket name"
  type        = string
}

variable "replica_name" {
  description = "Replica bucket name. Defaults to \"<name>-replica\"."
  type        = string
  nullable    = true
  default     = null
}

variable "replication_role_name" {
  description = "Replication IAM role name. Defaults to \"<name>-replication\"."
  type        = string
  nullable    = true
  default     = null
}

variable "object_ownership" {
  description = "Object ownership for the buckets. When null, ownership controls are not managed."
  type        = string
  nullable    = true
  default     = null
}

variable "bucket_key_enabled" {
  description = "Whether to use an S3 Bucket Key for SSE-KMS."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
