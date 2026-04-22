resource "aws_lambda_function_url" "public-url" {
  count = local.public-count

  function_name      = aws_lambda_function.lambda.function_name
  authorization_type = "NONE"
  cors {
    allow_origins = [
      "https://${var.public-access-cors-bare-domain}",
      "https://www.${var.public-access-cors-bare-domain}"
    ]
    allow_headers  = ["*"]
    allow_methods  = ["POST", "GET"]
    expose_headers = []
    max_age        = 86400
  }
}

resource "aws_lambda_permission" "allow-invoking" {
  count = local.public-count

  statement_id             = "InvokeFunction"
  action                   = "lambda:InvokeFunction"
  function_name            = aws_lambda_function.lambda.function_name
  principal                = "*"
  invoked_via_function_url = true
}

resource "aws_lambda_permission" "allow-public-access" {
  count = local.public-count

  function_name          = aws_lambda_function.lambda.function_name
  statement_id           = "AllowPublicAccess"
  action                 = "lambda:InvokeFunctionUrl"
  principal              = "*"
  function_url_auth_type = "NONE"
}
