resource "aws_dynamodb_table" "table" {
  name         = var.name
  billing_mode = var.billing-mode
  hash_key     = var.hash-key
  range_key    = var.range-key

  read_capacity  = var.billing-mode == "PROVISIONED" ? var.read-capacity : null
  write_capacity = var.billing-mode == "PROVISIONED" ? var.write-capacity : null

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.key
      type = attribute.value.data_type
    }
  }

  stream_enabled   = var.stream-view-type != null
  stream_view_type = var.stream-view-type

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
