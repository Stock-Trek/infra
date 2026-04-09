resource "aws_ecr_repository" "stock_trek" {
  for_each = toset(local.ecr_repositories)
  
  name = each.value
  image_tag_mutability = "IMMUTABLE"
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
}
