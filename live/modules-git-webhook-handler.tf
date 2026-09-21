module "lambda-git-webhook-handler" {
  source                         = "./lambda"
  name                           = local.git-webhook-handler-lambda
  github-account                 = local.github-account
  github-oidc-arn                = data.aws_iam_openid_connect_provider.github.arn
  memory                         = 1024
  timeout                        = 30
  role-update                    = local.git-webhook-handler-update-role
  package-type                   = "Zip"
  public-access-cors-bare-domain = "github.com"
  tags                           = local.tags
}

module "sqs-git-webhook-handler" {
  source = "./sqs"
  name   = local.git-webhook-handler-sqs-name
  dead-letter = {
    max-receive-count = 10
  }
  visibility-timeout = 300
  tags               = local.tags
}
