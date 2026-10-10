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
      name = attribute.key
      type = attribute.value
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global-secondary-indexes
    content {
      name            = global_secondary_index.key
      projection_type = global_secondary_index.value.projection-type
      non_key_attributes = (
        global_secondary_index.value.projection-type == "INCLUDE"
      ) ? global_secondary_index.value.non-key-attributes : null
      read_capacity  = global_secondary_index.value.read-capacity
      write_capacity = global_secondary_index.value.write-capacity

      dynamic "key_schema" {
        for_each = concat(
          [{
            attribute_name = global_secondary_index.value.hash-key
            key_type       = "HASH"
          }],
          global_secondary_index.value.range-key == null ? [] : [{
            attribute_name = global_secondary_index.value.range-key
            key_type       = "RANGE"
          }]
        )
        content {
          attribute_name = key_schema.value.attribute_name
          key_type       = key_schema.value.key_type
        }
      }
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
