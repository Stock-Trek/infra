locals {
  github-account                 = "Stock-Trek@269482059"
  github-repository-name-website = "website"

  website-bare-domain = "stock-trek.com"

  market-data-bucket      = "stock-trek-market-data"
  market-data-cron        = "rate(3 minutes)"
  market-data-update      = "stock-trek-market-data"
  market-data-lambda      = "stock-trek-market-data"
  market-data-event-rule  = "stock-trek-market-data"
  market-data-update-role = "StockTrekUpdateMarketData"

  dependency-whitelist-update-role = "StockTrekUpdateDependencyWhitelist"

  git-webhook-handler-sqs-name    = "stock-trek-git-webhook-handler"
  git-webhook-handler-lambda      = "stock-trek-git-webhook-handler"
  git-webhook-handler-update-role = "StockTrekUpdateGitWebhookHandler"
  git-webhook-handler-api-name    = "stock-trek-git-webhook-handler"

  build-agent-rust-bucket        = "stock-trek-user-artifacts"
  build-agent-rust-ecr-name      = "stock-trek-build-agent"
  build-agent-rust-ecr-image-tag = "master"
  build-agent-rust-ec2-name      = "stock-trek-build-agent"
  build-agent-rust-instance-type = "t4g.medium"

  tags = {
    Environment = "production"
  }
}
