locals {
  aws_region           = "eu-west-1"
  bare_domain          = "stock-trek.com"
  oidc_github_bare_url = "token.actions.githubusercontent.com"
  oidc_github_audience = ["sts.amazonaws.com"]
  oidc_github_subject  = ["repo:NathanJAdams/stocks/*"]
}
