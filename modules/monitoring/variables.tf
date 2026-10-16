variable "name" {
  description = "SNS topic name used for CloudWatch alarm notifications"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}

variable "email_subscriptions" {
  description = "Email addresses to subscribe to the alarm topic"
  type        = set(string)
  default     = []
}

variable "kms_master_key_id" {
  description = "KMS key used to encrypt the alarm topic, defaults to the AWS managed SNS key"
  type        = string
  default     = "alias/aws/sns"
}
