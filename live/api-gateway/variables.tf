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

variable "lambda-invoke-arn" {
  description = "Invoke ARN of the Lambda function to proxy requests to"
  type        = string
}

variable "lambda-name" {
  description = "Name of the Lambda function to proxy requests to"
  type        = string
}

variable "routes" {
  description = "Route keys to match requests against, use $default to match all requests"
  type        = list(string)
  default     = ["$default"]
}

variable "cors" {
  description = "Optional CORS configuration, no CORS configuration is applied when null"
  type = object({
    allow-origins = list(string)
  })
  nullable = true
  default  = null
}
