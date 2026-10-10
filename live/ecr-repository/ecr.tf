resource "aws_ecr_repository" "repository" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE_WITH_EXCLUSION"
  dynamic "image_tag_mutability_exclusion_filter" {
    for_each = var.mutability_exclusion_filter != null ? [1] : []
    content {
      filter_type = "WILDCARD"
      filter      = var.mutability_exclusion_filter
    }
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "remove_untagged" {
  repository = aws_ecr_repository.repository.name
  policy     = jsonencode(local.remove_untagged)
}
