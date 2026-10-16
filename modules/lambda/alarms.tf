resource "aws_cloudwatch_metric_alarm" "errors" {
  alarm_name          = "${var.name}-errors"
  alarm_description   = "Lambda ${var.name} reported errors"
  namespace           = "AWS/Lambda"
  metric_name         = "Errors"
  statistic           = "Sum"
  period              = var.alarm_period
  evaluation_periods  = var.alarm_evaluation_periods
  threshold           = var.error_alarm_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  dimensions = {
    FunctionName = aws_lambda_function.lambda.function_name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions
  tags          = var.tags
}

resource "aws_cloudwatch_metric_alarm" "throttles" {
  alarm_name          = "${var.name}-throttles"
  alarm_description   = "Lambda ${var.name} is being throttled"
  namespace           = "AWS/Lambda"
  metric_name         = "Throttles"
  statistic           = "Sum"
  period              = var.alarm_period
  evaluation_periods  = var.alarm_evaluation_periods
  threshold           = var.throttle_alarm_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  dimensions = {
    FunctionName = aws_lambda_function.lambda.function_name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions
  tags          = var.tags
}

resource "aws_cloudwatch_metric_alarm" "dead_letter_depth" {
  alarm_name          = "${var.name}-dead-letter-depth"
  alarm_description   = "Messages are building up on the ${var.name} dead letter queue"
  namespace           = "AWS/SQS"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  statistic           = "Maximum"
  period              = var.alarm_period
  evaluation_periods  = var.alarm_evaluation_periods
  threshold           = var.dead_letter_alarm_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  dimensions = {
    QueueName = aws_sqs_queue.dead_letter.name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions
  tags          = var.tags
}
