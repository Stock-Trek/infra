moved {
  from = module.api_git_webhook_handler
  to   = module.api_ref_sync
}

moved {
  from = module.api_git_webhook_handler_route_github
  to   = module.api_ref_sync_route_github
}

moved {
  from = module.bucket_git_webhook_handler_dlq
  to   = module.bucket_ref_sync_dlq
}

moved {
  from = module.dynamodb_git_webhook_handler
  to   = module.dynamodb_ref_sync
}

moved {
  from = module.dynamodb_lambda_git_webhook_handler
  to   = module.dynamodb_lambda_ref_sync
}

moved {
  from = module.ecs_run_task_git_webhook_handler
  to   = module.ecs_run_task_ref_sync
}

moved {
  from = module.lambda_git_webhook_handler
  to   = module.lambda_ref_sync
}
