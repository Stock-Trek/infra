resource "aws_apigatewayv2_api" "api" {
  name          = var.name
  protocol_type = local.protocol_type
  tags          = var.tags

  dynamic "cors_configuration" {
    for_each = local.cors_count == 1 ? [1] : []
    content {
      allow_origins  = var.cors.allow_origins
      allow_headers  = local.cors_allow_headers
      allow_methods  = local.cors_allow_methods
      expose_headers = local.cors_expose_headers
      max_age        = local.cors_max_age
    }
  }
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = local.stage_name
  auto_deploy = local.auto_deploy
  tags        = var.tags
}
