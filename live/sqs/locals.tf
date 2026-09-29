locals {
  queue_name       = var.fifo ? "${var.name}.fifo" : var.name
  dead_letter_name = var.fifo ? "${var.name}-dead-letter.fifo" : "${var.name}-dead-letter"
  content_based_deduplication = (
    var.fifo && var.deduplication.mode == "content"
  ) ? true : null
  deduplication_scope = var.fifo ? var.deduplication.id : null
  receive-wait        = 20
  dead-letter-count   = var.dead-letter == null ? 0 : 1
}
