resource "aws_cloudwatch_metric_alarm" "backlog" {
  alarm_name          = "${var.name}-backlog"
  alarm_description   = "Messages are building up on the ${var.name} queue"
  namespace           = "AWS/SQS"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  statistic           = "Maximum"
  period              = var.alarm_period
  evaluation_periods  = var.alarm_evaluation_periods
  threshold           = var.backlog_alarm_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  dimensions = {
    QueueName = aws_sqs_queue.queue.name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions
  tags          = var.tags
}

resource "aws_cloudwatch_metric_alarm" "age" {
  alarm_name          = "${var.name}-age"
  alarm_description   = "Messages are not being consumed quickly enough from the ${var.name} queue"
  namespace           = "AWS/SQS"
  metric_name         = "ApproximateAgeOfOldestMessage"
  statistic           = "Maximum"
  period              = var.alarm_period
  evaluation_periods  = var.alarm_evaluation_periods
  threshold           = var.age_alarm_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  dimensions = {
    QueueName = aws_sqs_queue.queue.name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions
  tags          = var.tags
}

resource "aws_cloudwatch_metric_alarm" "dead_letter_depth" {
  count = local.dead_letter_count

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
    QueueName = aws_sqs_queue.dead_letter[0].name
  }
  alarm_actions = var.alarm_actions
  ok_actions    = var.alarm_actions
  tags          = var.tags
}
