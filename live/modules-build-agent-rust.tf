module "bucket_build_agent_artifacts" {
  source = "./s3-bucket"
  name   = local.build_agent_rust_bucket
  tags   = local.tags
}

module "ecr_build_agent" {
  source                      = "./ecr-repository"
  name                        = local.build_agent_rust_ecr_name
  mutability_exclusion_filter = local.build_agent_rust_ecr_image_tag
  github_account              = local.github_account
  github_oidc_arn             = data.aws_iam_openid_connect_provider.github.arn
  role_update                 = local.build_agent_rust_update_role
  tags                        = local.tags
}

module "ecs_build_agent" {
  source = "./ecs"
  name   = local.build_agent_rust_task
  image = {
    repository_url = module.ecr_build_agent.repository_url
    image_tag      = local.build_agent_rust_ecr_image_tag
  }
  subnet_ids         = module.vpc_build_agent.subnet_ids
  security_group_ids = [module.vpc_build_agent.task_security_group_id]
  tags               = local.tags
}

module "s3_put_build_agent" {
  source     = "./glue/s3-put"
  role       = module.ecs_build_agent.task_role_name
  bucket_arn = module.bucket_build_agent_artifacts.arn
  prefix     = local.build_agent_rust_artifact_prefix
}

module "vpc_build_agent" {
  source           = "./vpc"
  name             = local.build_agent_rust_vpc
  nat_gateway_mode = "single"
  tags             = local.tags
}
