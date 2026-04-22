variable "name" {
  description = "Event rule name"
  type        = string
}

variable "lambda-arn" {
  description = "Lambda arn to run"
  type        = string
}

variable "lambda-name" {
  description = "Lambda function name"
  type        = string
}

variable "cron" {
  description = "Cron expression to run on"
  type        = string
}
