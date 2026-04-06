data "aws_iam_openid_connect_provider" "bootstrap_github" {
  url = "https://${local.oidc_github_bare_url}"
}
