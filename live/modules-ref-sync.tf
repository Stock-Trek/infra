module "api_ref_sync" {
  source = "./api-gateway"
  name   = local.ref_sync_api_name
  tags   = local.tags
}

module "api_ref_sync_route_github" {
  source            = "./glue/api-routes"
  api_id            = module.api_ref_sync.id
  api_execution_arn = module.api_ref_sync.execution_arn
  lambda_name       = local.ref_sync_lambda
  lambda_invoke_arn = module.lambda_ref_sync.invoke_arn
  routes = [{
    method = "POST"
    path   = "/github"
  }]
  depends_on = [module.api_ref_sync]
}

module "bucket_ref_sync_dlq" {
  source = "./s3-bucket"
  name   = local.ref_sync_bucket_dlq
  tags   = local.tags
}

module "dynamodb_ref_sync" {
  source = "./dynamodb"
  attributes = {
    pk           = "S"
    sk           = "S"
    host_repo_id = "S"
    status       = "S"
  }
  global_secondary_indexes = {
    "GSI-RepoByHostAndId" = {
      hash_key        = "host_repo_id"
      projection_type = "ALL"
    }
    "GSI-ByStatus" = {
      hash_key        = "status"
      range_key       = "pk"
      projection_type = "KEYS_ONLY"
    }
  }
  hash_key         = "pk"
  name             = "git-state"
  range_key        = "sk"
  ttl_attribute    = "ttl"
  stream_view_type = "NEW_AND_OLD_IMAGES"
}

module "dynamodb_lambda_ref_sync" {
  source                             = "./glue/dynamodb-lambda"
  bisect_batch_on_function_error     = true
  dlq_bucket_arn                     = module.bucket_ref_sync_dlq.arn
  lambda_arn                         = module.lambda_ref_sync.arn
  maximum_batching_window_in_seconds = 5
  maximum_record_age_in_seconds      = 60 * 60
  maximum_retry_attempts             = 3
  role_name                          = module.lambda_ref_sync.role_run_name
  stream_arn                         = module.dynamodb_ref_sync.stream_arn
  depends_on                         = [module.bucket_ref_sync_dlq, module.lambda_ref_sync, module.dynamodb_ref_sync]
}

module "ecs_run_task_ref_sync" {
  source              = "./glue/ecs-run-task"
  role                = module.lambda_ref_sync.role_run_name
  task_definition_arn = module.ecs_build_agent.task_definition_arn
  execution_role_arn  = module.ecs_build_agent.execution_role_arn
  task_role_arn       = module.ecs_build_agent.task_role_arn
  depends_on          = [module.lambda_ref_sync, module.ecs_build_agent]
}

module "lambda_ref_sync" {
  source          = "./lambda"
  name            = local.ref_sync_lambda
  github_account  = local.github_account
  github_oidc_arn = data.aws_iam_openid_connect_provider.github.arn
  memory          = 1024
  timeout         = 30
  role_update     = local.ref_sync_update_role
  package_type    = "Zip"
  env_vars = {
    BUILD_AGENT_CLUSTER_ARN         = module.ecs_build_agent.cluster_arn
    BUILD_AGENT_CONTAINER_NAME      = module.ecs_build_agent.container_name
    BUILD_AGENT_SECURITY_GROUP_IDS  = join(",", module.ecs_build_agent.security_group_ids)
    BUILD_AGENT_SUBNET_IDS          = join(",", module.ecs_build_agent.subnet_ids)
    BUILD_AGENT_TASK_DEFINITION_ARN = module.ecs_build_agent.task_definition_arn
    DYNAMODB_IDEMPOTENCY_TABLE      = local.build_agent_rust_dynamodb_table
    INFISICAL_BASE_URL              = "https://us.infisical.com"
    INFISICAL_IDENTITY_ID           = "7bbc17ad-dedb-4297-a89b-07f266374a38"
    INFISICAL_PROJECT_ID            = "a6b3a1c2-b598-4d17-80ac-da8f47a953f2"
    INFISICAL_ENVIRONMENT           = "prod"
  }
  tags = local.tags
}
