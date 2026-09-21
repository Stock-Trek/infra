resource "aws_sqs_queue" "queue" {
  name                        = var.name
  fifo_queue                  = var.fifo
  content_based_deduplication = var.fifo ? local.content-based-deduplication : null
  visibility_timeout_seconds  = local.visibility-timeout
  message_retention_seconds   = local.message-retention
  delay_seconds               = local.delay
  receive_wait_time_seconds   = local.receive-wait
  max_message_size            = local.max-message-size
  sqs_managed_sse_enabled     = local.kms-master-key-id == null
  kms_master_key_id           = local.kms-master-key-id
  redrive_policy = var.dead-letter == null ? null : jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead-letter[0].arn
    maxReceiveCount     = var.dead-letter.max-receive-count
  })
  tags = var.tags
}

resource "aws_sqs_queue" "dead-letter" {
  count = var.dead-letter != null ? 1 : 0

  name                       = "${var.name}-dead-letter"
  fifo_queue                 = var.fifo
  message_retention_seconds  = local.message-retention
  visibility_timeout_seconds = local.visibility-timeout
  receive_wait_time_seconds  = local.receive-wait
  sqs_managed_sse_enabled    = local.kms-master-key-id == null
  kms_master_key_id          = local.kms-master-key-id
  tags                       = var.tags
}

resource "aws_sqs_queue_redrive_allow_policy" "dead-letter" {
  count = var.dead-letter != null ? 1 : 0

  queue_url = aws_sqs_queue.dead-letter[0].id
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
}
