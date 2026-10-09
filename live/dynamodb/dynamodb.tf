resource "aws_dynamodb_table" "table" {
  name         = var.name
  billing_mode = var.billing-mode
  hash_key     = var.hash-key
  range_key    = var.range-key

  read_capacity  = var.billing-mode == "PROVISIONED" ? var.read-capacity : null
  write_capacity = var.billing-mode == "PROVISIONED" ? var.write-capacity : null

  attribute {
    name = var.hash-key
    type = var.hash-key-type
  }

  dynamic "attribute" {
    for_each = var.range-key == null ? [] : [1]
    content {
      name = var.range-key
      type = var.range-key-type
    }
  }

  stream_enabled   = var.stream-enabled
  stream_view_type = var.stream-enabled ? var.stream-view-type : null

  ttl {
    attribute_name = var.ttl-attribute
    enabled        = var.ttl-attribute != null
  }

  point_in_time_recovery {
    enabled = var.point-in-time-recovery
  }

  server_side_encryption {
    enabled = true
  }

  tags = var.tags
}
