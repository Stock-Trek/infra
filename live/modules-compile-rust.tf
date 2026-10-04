module "bucket-uploads" {
  source = "./s3-bucket"
  name   = local.compile-rust-bucket
  tags   = local.tags
}

module "ecr-algorithm-compiler" {
  source                      = "./ecr-repository"
  name                        = local.algorithm-compiler-ecr-name
  mutability-exclusion-filter = local.algorithm-compiler-ecr-image-tag
  tags                        = local.tags
}

module "lambda-compile-rust" {
  source          = "./lambda"
  name            = local.compile-rust-lambda
  github-account  = local.github-account
  github-oidc-arn = data.aws_iam_openid_connect_provider.github.arn
  memory          = 2048
  timeout         = 300
  role-update     = local.compile-rust-update-role
  package-type    = "Image"
  image = {
    ecr-repository-arn = module.ecr-algorithm-compiler.arn
    image-tag          = local.algorithm-compiler-ecr-image-tag
    repository-url     = module.ecr-algorithm-compiler.repository_url
  }
  env-vars = {
    AWS_CONNECT_TIMEOUT_SECONDS   = 10
    AWS_OPERATION_TIMEOUT_SECONDS = 120
    COMMAND_TIMEOUT_SECONDS       = 600
    DYNAMODB_LOCK_TABLE           = "stock-trek-repo-locks"
    INFISICAL_BASE_URL            = "https://us.infisical.com"
    INFISICAL_IDENTITY_ID         = "7bbc17ad-dedb-4297-a89b-07f266374a38"
    INFISICAL_PROJECT_ID          = "a6b3a1c2-b598-4d17-80ac-da8f47a953f2"
    INFISICAL_ENVIRONMENT         = "prod"
    S3_BUCKET_COMMIT_ARTIFACTS    = "stock-trek-commit-artifacts"
    SQS_URL                       = module.sqs-git-webhook-handler.url
  }
  tags = local.tags
}
