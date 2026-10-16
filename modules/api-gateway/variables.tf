variable "name" {
  description = "API Gateway name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}

variable "cors" {
  description = "Optional CORS configuration, no CORS configuration is applied when null"
  type = object({
    allow_origins = list(string)
  })
  nullable = true
  default  = null
}

# variable "log_retention_days" {
#   description = "CloudWatch access log retention in days"
#   type        = number
#   default     = 365
# }

variable "alarm_actions" {
  description = "List of ARNs (for example an SNS topic) notified when an alarm changes state"
  type        = list(string)
  default     = []
}

variable "alarm_period" {
  description = "CloudWatch alarm evaluation period in seconds"
  type        = number
  default     = 300
}

variable "alarm_evaluation_periods" {
  description = "Number of periods an alarm must breach before it triggers"
  type        = number
  default     = 1
}

variable "server_error_alarm_threshold" {
  description = "Number of 5xx responses in a period before alarming"
  type        = number
  default     = 1
}

variable "latency_alarm_threshold" {
  description = "p99 request latency in milliseconds before alarming"
  type        = number
  default     = 2000
}
