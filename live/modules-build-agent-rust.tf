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

module "vpc-build-agent" {
  source = "./vpc"
  name   = local.build-agent-rust-vpc
  tags   = local.tags
}

module "ecs-build-agent" {
  source = "./ecs"
  name   = local.build-agent-rust-task
  image = {
    repository-url = module.ecr-build-agent.repository_url
    image-tag      = local.build-agent-rust-ecr-image-tag
  }
  subnet-ids         = module.vpc-build-agent.subnet-ids
  security-group-ids = [module.vpc-build-agent.task-security-group-id]
  tags               = local.tags
}

module "s3-put-build-agent" {
  source     = "./glue/s3-put"
  role       = module.ecs-build-agent.task-role-name
  bucket-arn = module.bucket-build-agent-artifacts.arn
  prefix     = local.build-agent-rust-artifact-prefix
}
