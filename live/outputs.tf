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

output "uploaded_code_bucket" {
  value = aws_s3_bucket.uploaded_code.bucket
}

output "compiled_so_bucket" {
  value = aws_s3_bucket.compiled_so.bucket
}

output "uploaded_code_bucket_arn" {
  value = aws_s3_bucket.uploaded_code.arn
}

output "compiled_so_bucket_arn" {
  value = aws_s3_bucket.compiled_so.arn
}
