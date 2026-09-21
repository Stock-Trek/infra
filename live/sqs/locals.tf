locals {
  receive-wait      = 20
  dead-letter-count = var.dead-letter == null ? 0 : 1
}
