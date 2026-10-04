output "id" {
  value = aws_instance.instance.id
}

output "arn" {
  value = aws_instance.instance.arn
}

output "role-name" {
  value = aws_iam_role.instance.name
}

output "role-arn" {
  value = aws_iam_role.instance.arn
}
