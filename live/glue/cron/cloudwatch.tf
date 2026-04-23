resource "aws_cloudwatch_event_rule" "scheduled_rule" {
  name                = var.name
  description         = "Cron trigger for ${var.lambda-name} @ ${var.cron}"
  schedule_expression = var.cron
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.scheduled_rule.name
  target_id = "SendToLambda"
  arn       = var.lambda-arn
  retry_policy {
    maximum_retry_attempts       = var.retries
    maximum_event_age_in_seconds = var.retry-expiry-seconds
  }
}
