module "api_git_webhook_handler" {
  source = "./api-gateway"
  name   = local.git_webhook_handler_api_name
  tags   = local.tags
}

module "api_git_webhook_handler_route_github" {
  source            = "./glue/api-routes"
  api_id            = module.api_git_webhook_handler.id
  api_execution_arn = module.api_git_webhook_handler.execution_arn
  lambda_name       = local.git_webhook_handler_lambda
  lambda_invoke_arn = module.lambda_git_webhook_handler.invoke_arn
  routes = [{
    method = "POST"
    path   = "/github"
  }]
}

module "ecs_run_task_git_webhook_handler" {
  source              = "./glue/ecs-run-task"
  role                = module.lambda_git_webhook_handler.role_run_name
  task_definition_arn = module.ecs_build_agent.task_definition_arn
  execution_role_arn  = module.ecs_build_agent.execution_role_arn
  task_role_arn       = module.ecs_build_agent.task_role_arn
  depends_on          = [module.lambda_git_webhook_handler, module.ecs_build_agent]
}

module "lambda_git_webhook_handler" {
  source          = "./lambda"
  name            = local.git_webhook_handler_lambda
  github_account  = local.github_account
  github_oidc_arn = data.aws_iam_openid_connect_provider.github.arn
  memory          = 1024
  timeout         = 30
  role_update     = local.git_webhook_handler_update_role
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
