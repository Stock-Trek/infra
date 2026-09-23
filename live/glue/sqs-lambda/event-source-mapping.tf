resource "aws_lambda_event_source_mapping" "sqs" {
  event_source_arn                   = var.queue-arn
  function_name                      = var.lambda-name
  batch_size                         = var.batch-size
  maximum_batching_window_in_seconds = var.maximum-batching-window-in-seconds
  enabled                            = var.enabled
}
