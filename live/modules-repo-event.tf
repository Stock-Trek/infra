module "lambda-repo-event" {
  source                         = "./lambda"
  name                           = local.repo-event-lambda
  github-account                 = local.github-account
  github-oidc-arn                = data.aws_iam_openid_connect_provider.github.arn
  memory                         = 1024
  timeout                        = 30
  role-update                    = local.repo-event-update-role
  package-type                   = "Zip"
  public-access-cors-bare-domain = "github.com"
  tags                           = local.tags
}

module "sqs-repo-event" {
  source = "./sqs"
  name   = local.repo-event-sqs-name
  dead-letter = {
    max-receive-count = 10
  }
  visibility-timeout = 300
  tags               = local.tags
}
