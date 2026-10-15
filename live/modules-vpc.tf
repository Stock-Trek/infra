module "vpc" {
  source             = "./vpc"
  name               = local.vpc_name
  availability_zones = local.vpc_availability_zones
  nat_gateway_mode   = "per_az"
  tags               = local.tags
}
