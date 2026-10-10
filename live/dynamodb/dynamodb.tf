resource "aws_dynamodb_table" "table" {
  name             = var.name
  billing_mode     = var.billing.mode
  read_capacity    = var.billing.read-capacity
  write_capacity   = var.billing.write-capacity
  hash_key         = var.hash-key
  range_key        = var.range-key
  stream_enabled   = var.stream-view-type != null
  stream_view_type = var.stream-view-type

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.key
      type = attribute.value.type
    }
  }

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
