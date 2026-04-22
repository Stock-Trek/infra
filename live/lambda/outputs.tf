output "arn" {
  value = aws_lambda_function.lambda.arn
}

output "url" {
  value = (local.public-count == 1) ? aws_lambda_function_url.public-url[0].function_url : null
}

output "role-run-name" {
  value = local.role-run
}

output "role-run-arn" {
  value = aws_iam_role.run.arn
}
