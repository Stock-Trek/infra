resource "aws_sqs_queue" "queue" {
  name                        = local.queue_name
  fifo_queue                  = var.fifo
  content_based_deduplication = local.content_based_deduplication
  deduplication_scope         = local.deduplication_scope
  receive_wait_time_seconds   = local.receive-wait
  visibility_timeout_seconds  = var.visibility-timeout
  redrive_policy = var.dead-letter == null ? null : jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead-letter[0].arn
    maxReceiveCount     = var.dead-letter.max-receive-count
  })
  tags = var.tags
}

resource "aws_sqs_queue" "dead-letter" {
  count = local.dead-letter-count

  name                      = local.dead_letter_name
  fifo_queue                = var.fifo
  receive_wait_time_seconds = local.receive-wait
  tags                      = var.tags
}

resource "aws_sqs_queue_redrive_allow_policy" "dead-letter" {
  count = local.dead-letter-count

  queue_url = aws_sqs_queue.dead-letter[0].id
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
}
