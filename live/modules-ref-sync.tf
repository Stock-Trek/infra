module "api_ref_sync" {
  source = "./api-gateway"
  name   = local.ref_sync_api_name
  tags   = local.tags
}

module "api_ref_sync_route_github" {
  source            = "./glue/api-routes"
  api_id            = module.api_ref_sync.id
  api_execution_arn = module.api_ref_sync.execution_arn
  lambda_name       = local.ref_sync_lambda_webhook
  lambda_invoke_arn = module.lambda_ref_sync_webhook.invoke_arn
  routes = [{
    method = "POST"
    path   = "/github"
  }]
  depends_on = [module.api_ref_sync, module.lambda_ref_sync_webhook]
}

module "dynamodb_ref_sync_tombstones" {
  source           = "./dynamodb"
  name             = local.ref_sync_dynamodb_table_tombstone
  hash_key         = "pk"
  range_key        = "sk"
  ttl_attribute    = "ttl"
  stream_view_type = "NEW_AND_OLD_IMAGES"
  attributes = {
    pk       = "S"
    sk       = "S"
    scope_pk = "S"
    scope_sk = "S"
    audit_pk = "S"
    audit_sk = "S"
  }
  global_secondary_indexes = {
    "ByScope" = {
      hash_key        = "scope_pk"
      range_key       = "scope_sk"
      projection_type = "ALL"
    }
    "ByHostTypeTime" = {
      hash_key        = "audit_pk"
      range_key       = "audit_sk"
      projection_type = "KEYS_ONLY"
    }
  }
}

module "ecs_run_task_ref_sync" {
  source              = "./glue/ecs-run-task"
  role                = module.lambda_ref_sync_orchestrator.role_run_name
  task_definition_arn = module.ecs_build_agent.task_definition_arn
  cluster_arn         = module.ecs_build_agent.cluster_arn
  execution_role_arn  = module.ecs_build_agent.execution_role_arn
  task_role_arn       = module.ecs_build_agent.task_role_arn
  depends_on          = [module.lambda_ref_sync_orchestrator, module.ecs_build_agent]
}

module "lambda_ref_sync_webhook" {
  source             = "./lambda"
  name               = local.ref_sync_lambda_webhook
  github_account     = local.github_account
  github_oidc_arn    = data.aws_iam_openid_connect_provider.github.arn
  memory             = 1024
  timeout            = 30
  role_update        = local.ref_sync_webhook_update_role
  package_type       = "Zip"
  subnet_ids         = module.vpc_build_agent.subnet_ids
  security_group_ids = [module.vpc_build_agent.task_security_group_id]
  vpc_id             = module.vpc_build_agent.id
  env_vars = {
    INFISICAL_BASE_URL    = "https://us.infisical.com"
    INFISICAL_IDENTITY_ID = "7bbc17ad-dedb-4297-a89b-07f266374a38"
    INFISICAL_PROJECT_ID  = "a6b3a1c2-b598-4d17-80ac-da8f47a953f2"
    INFISICAL_ENVIRONMENT = "prod"
    SQS_URL               = module.sqs_ref_sync.url
  }
  tags = local.tags
}

module "lambda_ref_sync_orchestrator" {
  source          = "./lambda"
  name            = local.ref_sync_lambda_orchestrator
  github_account  = local.github_account
  github_oidc_arn = data.aws_iam_openid_connect_provider.github.arn
  memory          = 1024
  timeout         = 30
  role_update     = local.ref_sync_orchestrator_update_role
  package_type    = "Zip"
  env_vars = {
    BUILD_AGENT_CLUSTER_ARN         = module.ecs_build_agent.cluster_arn
    BUILD_AGENT_CONTAINER_NAME      = module.ecs_build_agent.container_name
    BUILD_AGENT_SECURITY_GROUP_IDS  = join(",", module.ecs_build_agent.security_group_ids)
    BUILD_AGENT_SUBNET_IDS          = join(",", module.ecs_build_agent.subnet_ids)
    BUILD_AGENT_TASK_DEFINITION_ARN = module.ecs_build_agent.task_definition_arn
    DYNAMODB_TOMBSTONE_TABLE        = local.ref_sync_dynamodb_table_tombstone
  }
  tags = local.tags
}

module "sqs_lambda_ref_sync" {
  source      = "./glue/sqs-lambda"
  queue_arn   = module.sqs_ref_sync.arn
  lambda_name = local.ref_sync_lambda_orchestrator
  role        = module.lambda_ref_sync_orchestrator.role_run_name
  depends_on  = [module.lambda_ref_sync_orchestrator, module.sqs_ref_sync]
}

module "sqs_ref_sync" {
  source             = "./sqs"
  fifo               = false
  name               = local.ref_sync_sqs_name
  role               = module.lambda_ref_sync_webhook.role_run_name
  visibility_timeout = 300
  dead_letter = {
    max_receive_count = 3
  }
  tags = local.tags
}
