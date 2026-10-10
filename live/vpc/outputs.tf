output "id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = aws_subnet.private[*].id
}

output "task_security_group_id" {
  value = aws_security_group.tasks.id
}
