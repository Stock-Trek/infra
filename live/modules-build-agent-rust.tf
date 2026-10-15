module "bucket_build_agent_artifacts" {
  source = "../modules/s3-bucket"
  name   = local.build_agent_rust_bucket
  tags   = local.tags

  object_ownership   = "BucketOwnerEnforced"
  bucket_key_enabled = true

  providers = {
    aws         = aws
    aws.replica = aws.us_east_1
  }
}

module "ecr_build_agent" {
  source          = "../modules/ecr-repository"
  name            = local.build_agent_rust_ecr_name
  github_account  = local.github_account
  github_oidc_arn = data.aws_iam_openid_connect_provider.github.arn
  role_update     = local.build_agent_rust_update_role
  tags            = local.tags
}

module "ecs_build_agent" {
  source = "../modules/ecs"
  name   = local.build_agent_rust_task
  image = {
    repository_url = module.ecr_build_agent.repository_url
    image_tag      = local.build_agent_rust_ecr_image_tag
  }
  tags = local.tags
}

module "s3_put_build_agent" {
  source     = "../modules/glue/s3-put"
  role       = module.ecs_build_agent.task_role_name
  bucket_arn = module.bucket_build_agent_artifacts.arn
  prefix     = local.build_agent_rust_artifact_prefix
}
