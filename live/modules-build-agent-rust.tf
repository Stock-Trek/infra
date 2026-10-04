module "bucket-build-agent-artifacts" {
  source = "./s3-bucket"
  name   = local.build-agent-rust-bucket
  tags   = local.tags
}

module "ecr-build-agent" {
  source                      = "./ecr-repository"
  name                        = local.build-agent-rust-ecr-name
  mutability-exclusion-filter = local.build-agent-rust-ecr-image-tag
  tags                        = local.tags
}

module "ec2-build-agent" {
  source        = "./ec2"
  name          = local.build-agent-rust-ec2-name
  instance-type = local.build-agent-rust-instance-type
  image = {
    ecr-repository-arn = module.ecr-build-agent.arn
    repository-url     = module.ecr-build-agent.repository_url
    image-tag          = local.build-agent-rust-ecr-image-tag
  }
  tags = local.tags
}
