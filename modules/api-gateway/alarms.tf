resource "aws_cloudwatch_metric_alarm" "server_errors" {
  alarm_name          = "${var.name}-5xx"
  alarm_description   = "API ${var.name} is returning 5xx responses"
  namespace           = "AWS/ApiGateway"
  metric_name         = "5XXError"
  statistic           = "Sum"
  period              = var.alarm_period
  evaluation_periods  = var.alarm_evaluation_periods
  threshold           = var.server_error_alarm_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  dimensions = {
    ApiId = aws_apigatewayv2_api.api.id
    Stage = aws_apigatewayv2_stage.stage.name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions
  tags          = var.tags
}

resource "aws_cloudwatch_metric_alarm" "latency" {
  alarm_name          = "${var.name}-latency"
  alarm_description   = "API ${var.name} p99 latency is above threshold"
  namespace           = "AWS/ApiGateway"
  metric_name         = "Latency"
  extended_statistic  = "p99"
  period              = var.alarm_period
  evaluation_periods  = var.alarm_evaluation_periods
  threshold           = var.latency_alarm_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  dimensions = {
    ApiId = aws_apigatewayv2_api.api.id
    Stage = aws_apigatewayv2_stage.stage.name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions
  tags          = var.tags
}
