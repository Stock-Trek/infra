resource "aws_sqs_queue" "queue" {
  name                      = var.name
  fifo_queue                = var.fifo
  receive_wait_time_seconds = local.receive-wait
  redrive_policy = var.dead-letter == null ? null : jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead-letter[0].arn
    maxReceiveCount     = var.dead-letter.max-receive-count
  })
  tags = var.tags
}

resource "aws_sqs_queue" "dead-letter" {
  count = var.dead-letter != null ? 1 : 0

  name                      = "${var.name}-dead-letter"
  fifo_queue                = var.fifo
  receive_wait_time_seconds = local.receive-wait
  tags                      = var.tags
}

resource "aws_sqs_queue_redrive_allow_policy" "dead-letter" {
  count = var.dead-letter != null ? 1 : 0

  queue_url = aws_sqs_queue.dead-letter[0].id
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
}
