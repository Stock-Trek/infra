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
