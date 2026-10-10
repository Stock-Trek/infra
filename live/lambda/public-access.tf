resource "aws_lambda_function_url" "public_url" {
  count = local.public_count

  function_name      = aws_lambda_function.lambda.function_name
  authorization_type = "NONE"
  cors {
    allow_origins = [
      "https://${var.public_access_cors_bare_domain}",
      "https://www.${var.public_access_cors_bare_domain}"
    ]
    allow_headers  = ["*"]
    allow_methods  = ["POST", "GET"]
    expose_headers = []
    max_age        = 86400
  }
}

resource "aws_lambda_permission" "allow_invoking" {
  count = local.public_count

  statement_id             = "InvokeFunction"
  action                   = "lambda:InvokeFunction"
  function_name            = aws_lambda_function.lambda.function_name
  principal                = "*"
  invoked_via_function_url = true
}

resource "aws_lambda_permission" "allow_public_access" {
  count = local.public_count

  function_name          = aws_lambda_function.lambda.function_name
  statement_id           = "AllowPublicAccess"
  action                 = "lambda:InvokeFunctionUrl"
  principal              = "*"
  function_url_auth_type = "NONE"
}
