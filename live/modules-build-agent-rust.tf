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

# module "lambda-build-agent-rust" {
#   source          = "./lambda"
#   name            = local.build-agent-rust-lambda
#   github-account  = local.github-account
#   github-oidc-arn = data.aws_iam_openid_connect_provider.github.arn
#   memory          = 2048
#   timeout         = 300
#   role-update     = local.build-agent-rust-update-role
#   package-type    = "Image"
#   image = {
#     ecr-repository-arn = module.ecr-build-agent.arn
#     image-tag          = local.build-agent-rust-ecr-image-tag
#     repository-url     = module.ecr-build-agent.repository_url
#   }
#   env-vars = {
#     AWS_CONNECT_TIMEOUT_SECONDS   = 10
#     AWS_OPERATION_TIMEOUT_SECONDS = 120
#     COMMAND_TIMEOUT_SECONDS       = 600
#     DYNAMODB_LOCK_TABLE           = local.build-agent-rust-dynamodb-table
#     INFISICAL_BASE_URL            = "https://us.infisical.com"
#     INFISICAL_IDENTITY_ID         = "7bbc17ad-dedb-4297-a89b-07f266374a38"
#     INFISICAL_PROJECT_ID          = "a6b3a1c2-b598-4d17-80ac-da8f47a953f2"
#     INFISICAL_ENVIRONMENT         = "prod"
#     S3_BUCKET_COMMIT_ARTIFACTS    = local.build-agent-rust-bucket
#     SQS_URL                       = module.sqs-git-webhook-handler.url
#   }
#   tags = local.tags
# }

# module "parameter-store-build-agent-dependency-whitelist" {
#   source           = "./glue/parameter-store"
#   prefix           = local.build-agent-rust-dependency-whitelist-prefix
#   repo-name        = local.build-agent-rust-dependency-whitelist-repo
#   lambda-role-name = local.build-agent-rust-update-role
#   writer-role-name = local.build-agent-rust-dependency-whitelist-update-role
#   github-account   = local.github-account
#   github-oidc-arn  = data.aws_iam_openid_connect_provider.github.arn
#   depends_on       = [module.lambda-build-agent-rust]
# }

# module "s3-access-build-agent" {
#   source      = "./glue/s3-access"
#   role        = module.lambda-build-agent-rust.role-run-name
#   bucket-arns = [module.bucket-build-agent-artifacts.arn]
#   depends_on  = [module.lambda-build-agent-rust]
# }

# module "sqs-lambda-build-agent-rust" {
#   source      = "./glue/sqs-lambda"
#   queue-arn   = module.sqs-git-webhook-handler.arn
#   lambda-name = local.build-agent-rust-lambda
#   role        = module.lambda-build-agent-rust.role-run-name
#   batch-size  = 1
#   depends_on  = [module.lambda-build-agent-rust, module.sqs-git-webhook-handler]
# }
