output "arn" {
  value = aws_ecr_repository.repository.arn
}

output "repository_url" {
  value = aws_ecr_repository.repository.repository_url
}

output "role-update-name" {
  value = aws_iam_role.update.name
}
