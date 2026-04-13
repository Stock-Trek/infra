resource "aws_lambda_function" "stock-trek-compile-rust" {
  for_each       = toset(local.algorithm_runner_handlers)

  function_name = "stock-trek-compile-rust-${each.key}"
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.stock_trek["algorithm-runner"].repository_url}:${var.algorithm_runner_image_tag}"
  image_config {
    command = ["handler.${each.key}"]
  }
  role          = aws_iam_role.run_lambda.arn
  publish       = true
  memory_size   = 2048
  timeout       = 30
  depends_on    = [
    aws_iam_role_policy_attachment.logs,
    aws_iam_role_policy_attachment.pull_image
  ]
}

resource "aws_lambda_function_url" "stock-trek-compile-rust" {
  for_each       = aws_lambda_function.stock-trek-compile-rust

  function_name      = each.value.function_name
  authorization_type = "NONE"

  cors {
    allow_origins     = [
      "https://${local.bare_domain}",
      "https://www.${local.bare_domain}"
    ]
    allow_methods     = [
      "GET",
      "POST",
      "OPTIONS"
    ]
    allow_headers     = [
      "content-type",
      "x-api-key"
    ]
    expose_headers    = []
    max_age           = 86400
  }
}

resource "aws_lambda_permission" "function_url_invoke" {
  for_each = aws_lambda_function_url.stock-trek-compile-rust

  statement_id  = "FunctionURLAllowPublicAccess-${each.key}"
  action        = "lambda:InvokeFunctionUrl"
  function_name = aws_lambda_function.stock-trek-compile-rust[each.key].function_name
  principal     = "*"
  function_url_auth_type = "NONE"
}

