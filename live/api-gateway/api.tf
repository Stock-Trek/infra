resource "aws_apigatewayv2_api" "api" {
  name          = var.name
  protocol_type = local.protocol-type
  tags          = var.tags

  dynamic "cors_configuration" {
    for_each = local.cors-count == 1 ? [1] : []
    content {
      allow_origins  = var.cors.allow-origins
      allow_headers  = local.cors-allow-headers
      allow_methods  = local.cors-allow-methods
      expose_headers = local.cors-expose-headers
      max_age        = local.cors-max-age
    }
  }
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = local.stage-name
  auto_deploy = local.auto-deploy
  tags        = var.tags
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.api.id
  integration_type       = local.integration-type
  integration_uri        = var.lambda-invoke-arn
  payload_format_version = local.payload-format-version
}

resource "aws_apigatewayv2_route" "route" {
  for_each = toset(var.routes)

  api_id    = aws_apigatewayv2_api.api.id
  route_key = each.value
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_lambda_permission" "allow-api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda-name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
