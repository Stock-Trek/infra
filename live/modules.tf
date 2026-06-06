module "bucket-market-data" {
  source = "./s3-bucket"
  name   = local.market-data-bucket
  tags   = local.tags
}

module "bucket-uploads" {
  source = "./s3-bucket"
  name   = local.compile-rust-bucket
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
}

module "s3-access-market-data" {
  source      = "./glue/s3-access"
  role        = module.lambda-market-data.role-run-name
  bucket-arns = [module.bucket-market-data.arn]
  depends_on  = [module.lambda-market-data]
}

module "parameter-store-market-data" {
  source            = "./glue/parameter-store"
  prefix            = "/stock-trek/market-data"
  repo-name         = "market-data"
  lambda-role-name  = module.lambda-market-data.role-run-name
  github-account    = local.github-account
  github-oidc-arn   = data.aws_iam_openid_connect_provider.github.arn
  depends_on        = [module.lambda-market-data]
}

# module "cron-update-market-data" {
#   source      = "./glue/cron"
#   name        = local.market-data-event-rule
#   cron        = local.market-data-cron
#   lambda-arn  = module.lambda-market-data.arn
#   lambda-name = local.market-data-lambda
# }

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
  public-access-cors-bare-domain = local.website-bare-domain
}

module "s3-access-compile-rust" {
  source      = "./glue/s3-access"
  role        = module.lambda-compile-rust.role-run-name
  bucket-arns = [module.bucket-uploads.arn]
  depends_on  = [module.lambda-compile-rust]
}

module "ecr-algorithm-compiler" {
  source                      = "./ecr-repository"
  name                        = local.algorithm-compiler-ecr-name
  mutability-exclusion-filter = local.algorithm-compiler-ecr-image-tag
  tags                        = local.tags
}

module "website-stock-trek" {
  source                      = "github.com/NathanJAdams/aws_s3_website.git?ref=master"
  bare_domain                 = local.website-bare-domain
  error_file                  = null
  oidc_role_name              = "StockTrekUpdateWebsite"
  oidc_connector              = "GitHub"
  oidc_github_account_name    = local.github-account
  oidc_github_repository_name = local.github-repository-name-website
  tags                        = local.tags
  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
