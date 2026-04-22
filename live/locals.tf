locals {
  bare-domain                    = "stock-trek.com"
  github-account                 = "Stock-Trek"
  github-repository-name-website = "website"
  bucket-market-data             = "stock-trek-market-data"
  bucket-uploads                 = "stock-trek-uploads"
  lambda-market-data             = "stock-trek-market-data"
  lambda-compile-rust            = "stock-trek-compile-rust"
  role-update-code-market-data   = "StockTrekUpdateCodeMarketData"
  role-update-code-compile-rust  = "StockTrekUpdateCodeCompileRust"
  tags = {
    Environment = "production"
  }
}
