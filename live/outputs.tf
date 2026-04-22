output "bucket-market-data-arn" {
  value = module.bucket-market-data.arn
}

output "bucket-uploads-arn" {
  value = module.bucket-uploads.arn
}

output "lambda-market-data-arn" {
  value = module.lambda-market-data.arn
}

output "lambda-compile-rust-arn" {
  value = module.lambda-compile-rust.arn
}

output "lambda-compile-rust-url" {
  value = module.lambda-compile-rust.url
}

output "website-url" {
  value = module.website-stock-trek.url
}

output "website-bucket" {
  value = module.website-stock-trek.bucket
}

output "website-bucket-update-role" {
  value = module.website-stock-trek.role
}

output "website-cloudfront-distribution-id" {
  value = module.website-stock-trek.cloudfront_distribution_id
}
