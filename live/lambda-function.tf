resource "aws_lambda_function" "stock-trek-check-compile-rust" {
  function_name = "stock-trek-check-compile-rust"
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.stock_trek["algorithm-runner"].repository_url}:${var.algorithm_runner_image_tag}"
  image_config {
    command = ["checker.check_handler"]
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

resource "aws_lambda_function_url" "stock-trek-check-compile-rust" {
  function_name      = aws_lambda_function.stock-trek-check-compile-rust.function_name
  authorization_type = "NONE"

  cors {
    allow_origins     = [
      "https://${local.bare_domain}",
      "https://www.${local.bare_domain}"
    ]
    allow_methods     = [
      "GET",
      "POST"
    ]
    allow_headers     = [
      "content-type"
    ]
    expose_headers    = []
    max_age           = 86400
  }
}

