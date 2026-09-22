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

  compile-rust-lambda      = "stock-trek-compile-rust"
  compile-rust-update-role = "StockTrekUpdateCompileRust"
  compile-rust-bucket      = "stock-trek-uploads"

  algorithm-compiler-ecr-name      = "algorithm-compiler"
  algorithm-compiler-ecr-image-tag = "master"

  tags = {
    Environment = "production"
  }
}
