locals {
  build-agent-rust-bucket                           = "stock-trek-user-artifacts"
  build-agent-rust-dependency-whitelist-prefix      = "/stock-trek/dependency-whitelist"
  build-agent-rust-dependency-whitelist-repo        = "stock-trek-dependency-whitelist"
  build-agent-rust-dependency-whitelist-update-role = "StockTrekUpdateDependencyWhitelist"
  build-agent-rust-dynamodb-table                   = "stock-trek-repo-locks"
  build-agent-rust-ecr-image-tag                    = "master"
  build-agent-rust-ecr-name                         = "stock-trek-build-agent"
  build-agent-rust-lambda                           = "stock-trek-build-agent"
  build-agent-rust-update-role                      = "StockTrekUpdateBuildAgent"

  git-webhook-handler-api-name    = "stock-trek-git-webhook-handler"
  git-webhook-handler-lambda      = "stock-trek-git-webhook-handler"
  git-webhook-handler-sqs-name    = "stock-trek-git-webhook-handler"
  git-webhook-handler-update-role = "StockTrekUpdateGitWebhookHandler"

  github-account                 = "Stock-Trek@269482059"
  github-repository-name-website = "website"

  market-data-bucket      = "stock-trek-market-data"
  market-data-cron        = "rate(3 minutes)"
  market-data-event-rule  = "stock-trek-market-data"
  market-data-lambda      = "stock-trek-market-data"
  market-data-update-role = "StockTrekUpdateMarketData"

  website-bare-domain = "stock-trek.com"

  tags = {
    Environment = "production"
  }
}
