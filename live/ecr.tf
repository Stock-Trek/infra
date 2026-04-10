resource "aws_ecr_repository" "stock_trek" {
  for_each = toset(local.ecr_repositories)
  
  name = each.value
  image_tag_mutability = "IMMUTABLE_WITH_EXCLUSION"
  image_tag_mutability_exclusion_filter {
    filter_type = "WILDCARD"
    filter      = "latest"
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
}
