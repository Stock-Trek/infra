module "lambda-git-webhook-handler" {
  source          = "./lambda"
  name            = local.git-webhook-handler-lambda
  github-account  = local.github-account
  github-oidc-arn = data.aws_iam_openid_connect_provider.github.arn
  memory          = 1024
  timeout         = 30
  role-update     = local.git-webhook-handler-update-role
  package-type    = "Zip"
  env-vars = {
    INFISICAL_BASE_URL    = "https://us.infisical.com"
    INFISICAL_IDENTITY_ID = "7bbc17ad-dedb-4297-a89b-07f266374a38"
    INFISICAL_PROJECT_ID  = "a6b3a1c2-b598-4d17-80ac-da8f47a953f2"
    INFISICAL_ENVIRONMENT = "prod"
  }
  tags = local.tags
}

module "sqs-git-webhook-handler" {
  source = "./sqs"
  name   = local.git-webhook-handler-sqs-name
  role   = module.lambda-git-webhook-handler.role-run-name
  dead-letter = {
    max-receive-count = 10
  }
  visibility-timeout = 300
  tags               = local.tags
}

module "api-git-webhook-handler" {
  source = "./api-gateway"
  name   = local.git-webhook-handler-api-name
  tags   = local.tags
}

module "api-git-webhook-handler-route-github" {
  source            = "./glue/api-routes"
  api-id            = module.api-git-webhook-handler.id
  api-execution-arn = module.api-git-webhook-handler.execution-arn
  lambda-name       = local.git-webhook-handler-lambda
  lambda-invoke-arn = module.lambda-git-webhook-handler.invoke-arn
  routes = [{
    method = "POST"
    path   = "/github"
  }]
}
