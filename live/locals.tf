locals {
  build_agent_rust_artifact_prefix                  = "artifacts"
  build_agent_rust_bucket                           = "stock-trek-user-artifacts"
  build_agent_rust_dependency_whitelist_prefix      = "/stock-trek/dependency-whitelist"
  build_agent_rust_dependency_whitelist_repo        = "stock-trek-dependency-whitelist"
  build_agent_rust_dependency_whitelist_update_role = "StockTrekUpdateDependencyWhitelist"
  build_agent_rust_dynamodb_table                   = "stock-trek-idempotency-locks"
  build_agent_rust_ecr_image_tag                    = "master"
  build_agent_rust_ecr_name                         = "stock-trek-build-agent"
  build_agent_rust_lambda                           = "stock-trek-build-agent"
  build_agent_rust_task                             = "stock-trek-build-agent"
  build_agent_rust_update_role                      = "StockTrekUpdateBuildAgent"
  build_agent_rust_vpc                              = "stock-trek-build-agent"

  git_webhook_handler_api_name    = "stock-trek-git-webhook-handler"
  git_webhook_handler_lambda      = "stock-trek-git-webhook-handler"
  git_webhook_handler_sqs_name    = "stock-trek-git-webhook-handler"
  git_webhook_handler_update_role = "StockTrekUpdateGitWebhookHandler"

  github_account                 = "Stock-Trek@269482059"
  github_repository_name_website = "website"

  market_data_bucket      = "stock-trek-market-data"
  market_data_cron        = "rate(3 minutes)"
  market_data_event_rule  = "stock-trek-market-data"
  market_data_lambda      = "stock-trek-market-data"
  market_data_update_role = "StockTrekUpdateMarketData"

  website_bare_domain = "stock-trek.com"

  tags = {
    Environment = "production"
  }
}
