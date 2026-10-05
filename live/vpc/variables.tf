variable "name" {
  description = "VPC name"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability-zone-count" {
  description = "Number of availability zones to place private subnets in"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  nullable    = true
  default     = {}
}
