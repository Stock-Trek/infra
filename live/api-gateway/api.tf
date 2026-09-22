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
