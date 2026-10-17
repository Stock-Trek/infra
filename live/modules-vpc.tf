module "vpc" {
  source             = "../modules/vpc"
  name               = local.vpc_name
  availability_zones = local.vpc_availability_zones
  tags               = local.tags
}
