locals {
  bare_domain                     = "stock-trek.com"
  github_account_name             = "Stock-Trek"
  github_repository_name_website  = "website"
  ecr_repositories                = [
    "algorithm-runner"
  ]
  role_push_image                 = "StockTrekPushImage"
  role_run_lambda                 = "StockTrekRunLambda"
  algorithm_runner_handlers       = [
    "check",
    "save"
  ]
  
  s3_buckets = {
    raw_code  = "stock-trek-raw-code"
    cwasm     = "stock-trek-compiled-cwasm"
    metadata  = "stock-trek-metadata"
  }
}
