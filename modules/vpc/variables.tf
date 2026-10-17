variable "name" {
  description = "VPC name"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zone names to place subnets in. Pinning the zone identity prevents the VPC's subnet set from silently expanding when AWS adds an Availability Zone."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) > 0
    error_message = "availability_zones must contain at least one availability zone."
  }
}

variable "log_retention_days" {
  description = "CloudWatch flow log retention in days"
  type        = number
  default     = 365
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
