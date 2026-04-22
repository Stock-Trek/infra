module "bucket-market-data" {
  source = "./s3-bucket"
  name   = local.bucket-market-data
  tags   = local.tags
}

module "bucket-uploads" {
  source = "./s3-bucket"
  name   = local.bucket-uploads
  tags   = local.tags
}

module "lambda-market-data" {
  source           = "./lambda"
  name             = local.lambda-market-data
  github-account   = local.github-account
  github-oidc-arn  = data.aws_iam_openid_connect_provider.github.arn
  memory           = 2048
  timeout          = 300
  role-update-code = local.role-update-code-market-data
}

module "s3-access-market-data" {
  source      = "./glue/s3-access"
  role        = module.lambda-market-data.role-run-name
  bucket-arns = [module.bucket-market-data.arn]
  depends_on  = [module.lambda-market-data]
}

module "lambda-compile-rust" {
  source                         = "./lambda"
  name                           = local.lambda-compile-rust
  github-account                 = local.github-account
  github-oidc-arn                = data.aws_iam_openid_connect_provider.github.arn
  memory                         = 2048
  timeout                        = 300
  role-update-code               = local.role-update-code-compile-rust
  public-access-cors-bare-domain = local.bare-domain
}

module "s3-access-compile-rust" {
  source      = "./glue/s3-access"
  role        = module.lambda-compile-rust.role-run-name
  bucket-arns = [module.bucket-uploads.arn]
  depends_on  = [module.lambda-compile-rust]
}

module "website-stock-trek" {
  source                      = "github.com/NathanJAdams/aws_s3_website.git?ref=master"
  bare_domain                 = local.bare-domain
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
