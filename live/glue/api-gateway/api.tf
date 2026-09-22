resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = var.api-id
  integration_type       = local.integration-type
  integration_uri        = var.lambda-invoke-arn
  payload_format_version = local.payload-format-version
}

resource "aws_apigatewayv2_route" "route" {
  for_each = toset(var.routes)

  api_id    = var.api-id
  route_key = each.value
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_lambda_permission" "allow-api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda-name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api-execution-arn}/*/*"
}
