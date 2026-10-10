locals {
  remove_untagged = {
    rules = [
      {
        rulePriority = 1
        description  = "Keep at most 1 untagged image"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 1
        }
        action = {
          type = "expire"
        }
      }
    ]
  }
}
