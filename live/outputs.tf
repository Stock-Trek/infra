output "compile_rust_lambda_urls" {
  value = {
    for name, lambda_url in aws_lambda_function_url.stock-trek-compile-rust : name => lambda_url.function_url
  }
}

output "website_url" {
  value = module.stock-trek.url
}

output "website_bucket" {
  value = module.stock-trek.bucket
}

output "website_bucket_update_role" {
  value = module.stock-trek.role
}

output "website_cloudfront_distribution_id" {
  value = module.stock-trek.cloudfront_distribution_id
}

output "s3_buckets" {
  value = {
    for key, bucket in aws_s3_bucket.buckets : key => {
      name = bucket.bucket
      arn  = bucket.arn
    }
  }
}
