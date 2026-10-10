resource "aws_lambda_event_source_mapping" "dynamodb" {
  event_source_arn                   = var.stream-arn
  function_name                      = var.lambda-arn
  batch_size                         = var.batch-size
  maximum_batching_window_in_seconds = var.maximum-batching-window-in-seconds
  starting_position                  = var.starting-position
  bisect_batch_on_function_error     = var.bisect-batch-on-function-error
  maximum_retry_attempts             = var.maximum-retry-attempts
  maximum_record_age_in_seconds      = var.maximum-record-age-in-seconds
  enabled                            = true

  destination_config {
    on_failure {
      destination_arn = var.dlq-bucket-arn
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.consume,
    aws_iam_role_policy_attachment.dlq-write,
  ]
}
