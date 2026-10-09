resource "aws_lambda_event_source_mapping" "dynamodb" {
  event_source_arn                   = var.stream-arn
  function_name                      = var.lambda-name
  batch_size                         = var.batch-size
  maximum_batching_window_in_seconds = var.maximum-batching-window-in-seconds
  starting_position                  = var.starting-position
  enabled                            = var.enabled

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
