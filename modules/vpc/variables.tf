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

variable "nat_gateway_mode" {
  description = "NAT Gateway topology. none: no NAT gateway, Elastic IP, or private default route. single: one NAT gateway shared by every private subnet (not highly available; dev/test only). per_az: one NAT gateway per availability zone, with each private route table targeting the NAT gateway in its own AZ (production-safe)."
  type        = string
  default     = "none"

  validation {
    condition     = contains(["none", "single", "per_az"], var.nat_gateway_mode)
    error_message = "nat_gateway_mode must be one of: none, single, per_az."
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
