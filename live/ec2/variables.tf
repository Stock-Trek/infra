variable "name" {
  description = "EC2 instance name"
  type        = string
}

variable "instance-type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.medium"
}

variable "image" {
  description = "Container image to run on the instance"
  type = object({
    ecr-repository-arn = string
    repository-url     = string
    image-tag          = string
  })
}

variable "port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
