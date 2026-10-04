variable "role" {
  description = "Role to attach EC2 access to"
  type        = string
}

variable "instance-arn" {
  description = "EC2 instance arn to grant access to"
  type        = string
}
