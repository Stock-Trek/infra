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
