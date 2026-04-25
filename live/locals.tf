locals {
  github-account                 = "Stock-Trek"
  github-repository-name-website = "website"

  website-bare-domain = "stock-trek.com"

  market-data-bucket      = "stock-trek-market-data"
  market-data-cron        = "rate(3 minutes)"
  market-data-update      = "stock-trek-market-data"
  market-data-lambda      = "stock-trek-market-data"
  market-data-event-rule  = "stock-trek-market-data"
  market-data-update-role = "StockTrekUpdateMarketData"

  compile-rust-lambda      = "stock-trek-compile-rust"
  compile-rust-update-role = "StockTrekUpdateCompileRust"
  compile-rust-bucket      = "stock-trek-uploads"

  algorithm-compiler-ecr-name      = "algorithm-compiler"
  algorithm-compiler-ecr-image-tag = "master"

  tags = {
    Environment = "production"
  }
}
