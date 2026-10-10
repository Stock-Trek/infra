moved {
  from = module.bucket-build-agent-artifacts
  to   = module.bucket_build_agent_artifacts
}

moved {
  from = module.ecr-build-agent
  to   = module.ecr_build_agent
}

moved {
  from = module.ecs-build-agent
  to   = module.ecs_build_agent
}

moved {
  from = module.s3-put-build-agent
  to   = module.s3_put_build_agent
}

moved {
  from = module.vpc-build-agent
  to   = module.vpc_build_agent
}

moved {
  from = module.api-git-webhook-handler
  to   = module.api_git_webhook_handler
}

moved {
  from = module.api-git-webhook-handler-route-github
  to   = module.api_git_webhook_handler_route_github
}

moved {
  from = module.ecs-run-task-git-webhook-handler
  to   = module.ecs_run_task_git_webhook_handler
}

moved {
  from = module.lambda-git-webhook-handler
  to   = module.lambda_git_webhook_handler
}

moved {
  from = module.bucket-market-data
  to   = module.bucket_market_data
}

moved {
  from = module.lambda-market-data
  to   = module.lambda_market_data
}

moved {
  from = module.s3-access-market-data
  to   = module.s3_access_market_data
}

moved {
  from = module.website-stock-trek
  to   = module.website_stock_trek
}
