# resource "aws_ecr_lifecycle_policy" "cleanup" {
#   for_each = aws_ecr_repository.stock_trek
#   
#   repository = each.value.name
#   policy = jsonencode({
#     rules = [{
#       rulePriority = 1
#       action = {
#         type = "expire"
#       }
#       description  = "Keep last 10 images"
#       selection = {
#         tagStatus   = "any"
#         countType   = "imageCountMoreThan"
#         countNumber = 10
#       }
#     }]
#   })
# }
