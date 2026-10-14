resource "aws_ecr_repository" "repository" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
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
