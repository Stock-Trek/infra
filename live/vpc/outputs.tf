output "id" {
  value = aws_vpc.vpc.id
}

output "subnet-ids" {
  value = aws_subnet.private[*].id
}

output "task-security-group-id" {
  value = aws_security_group.tasks.id
}
