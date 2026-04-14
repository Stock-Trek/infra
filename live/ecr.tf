resource "aws_ecr_repository" "stock_trek" {
  for_each = toset(local.ecr_repositories)
  
  name = each.value
  image_tag_mutability = "IMMUTABLE_WITH_EXCLUSION"
  image_tag_mutability_exclusion_filter {
    filter_type = "WILDCARD"
    filter      = "master"
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "cleanup_untagged" {
  for_each = aws_ecr_repository.stock_trek
  
  repository = each.value.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Delete untagged images"
      selection = {
        tagStatus   = "untagged"
        countType   = "imageCountMoreThan"
        countNumber = 0
      }
      action = {
        type = "expire"
      }
    }]
  })
}
