variable "api-id" {
  description = "API Gateway id to integrate with"
  type        = string
}

variable "api-execution-arn" {
  description = "API Gateway execution ARN to grant invocation from"
  type        = string
}

variable "lambda-name" {
  description = "Name of the Lambda function to proxy requests to"
  type        = string
}

variable "lambda-invoke-arn" {
  description = "Invoke ARN of the Lambda function to proxy requests to"
  type        = string
}

variable "routes" {
  description = "Route keys to match requests against, use $default to match all requests"
  type        = list(string)
  default     = ["$default"]
}
