resource "aws_lambda_function" "stock-trek-market-data-updater" {
  function_name     = "stock-trek-market-data-updater"
  package_type      = "Zip"
  handler           = "bootstrap"
  filename          = data.archive_file.dummy.output_path
  source_code_hash  = data.archive_file.dummy.output_base64sha256
  runtime           = "provided.al2023"
  role              = aws_iam_role.run_lambda.arn
  publish           = true
  architectures     = ["x86_64"]
  memory_size       = 2048
  timeout           = 300
  depends_on        = [
    aws_iam_role_policy_attachment.logs,
    aws_iam_role_policy_attachment.pull_image
  ]
  lifecycle {
    ignore_changes  = [
      filename,
      source_code_hash,
    ]
  }
}

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
  architectures = ["x86_64"]
  memory_size   = 2048
  timeout       = 300
  depends_on    = [
    aws_iam_role_policy_attachment.logs,
    aws_iam_role_policy_attachment.pull_image
  ]
}

resource "aws_lambda_function_url" "stock-trek-compile-rust" {
  for_each            = aws_lambda_function.stock-trek-compile-rust

  function_name       = each.value.function_name
  authorization_type  = "NONE"

  cors {
    allow_origins     = [
      "https://${local.bare_domain}",
      "https://www.${local.bare_domain}"
    ]
    allow_headers     = ["*"]
    allow_methods     = ["POST", "GET"]
    expose_headers    = []
    max_age           = 86400
  }
}

resource "aws_lambda_permission" "stock-trek-invoke-function" {
  for_each                  = aws_lambda_function_url.stock-trek-compile-rust

  statement_id              = "InvokeFunction"
  action                    = "lambda:InvokeFunction"
  function_name             = aws_lambda_function.stock-trek-compile-rust[each.key].function_name
  principal                 = "*"
  invoked_via_function_url  = true
}

resource "aws_lambda_permission" "stock-trek-invoke-function-url" {
  for_each                  = aws_lambda_function_url.stock-trek-compile-rust

  statement_id              = "AllowPublicAccess"
  action                    = "lambda:InvokeFunctionUrl"
  function_name             = aws_lambda_function.stock-trek-compile-rust[each.key].function_name
  principal                 = "*"
  function_url_auth_type    = "NONE"
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/files/dummy_bootstrap.zip"
  source {
    content  = "#!/bin/bash\nexit 0"
    filename = "bootstrap"
  }
  depends_on = [null_resource.trigger]
}

resource "null_resource" "trigger" {}
