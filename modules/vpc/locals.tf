locals {
  interface_endpoints = ["ecr.api", "ecr.dkr", "logs"]
  nat_count = {
    none   = 0
    single = 1
    per_az = length(var.availability_zones)
  }[var.nat_gateway_mode]
}
