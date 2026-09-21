module "bucket-market-data" {
  source = "./s3-bucket"
  name   = local.market-data-bucket
  tags   = local.tags
}

module "lambda-market-data" {
  source          = "./lambda"
  name            = local.market-data-lambda
  github-account  = local.github-account
  github-oidc-arn = data.aws_iam_openid_connect_provider.github.arn
  memory          = 2048
  timeout         = 300
  role-update     = local.market-data-update-role
  package-type    = "Zip"
  tags            = local.tags
}

module "s3-access-market-data" {
  source      = "./glue/s3-access"
  role        = module.lambda-market-data.role-run-name
  bucket-arns = [module.bucket-market-data.arn]
  depends_on  = [module.lambda-market-data]
}

# module "cron-update-market-data" {
#   source      = "./glue/cron"
#   name        = local.market-data-event-rule
#   cron        = local.market-data-cron
#   lambda-arn  = module.lambda-market-data.arn
#   lambda-name = local.market-data-lambda
# }
