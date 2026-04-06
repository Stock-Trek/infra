resource "aws_ecr_repository" "stock_trek" {
  name = "stock-trek"
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "cleanup" {
  repository = aws_ecr_repository.stock_trek.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      action = {
        type = "expire"
      }
      description  = "Keep last 10 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
    }]
  })
}
