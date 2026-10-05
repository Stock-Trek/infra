output "cluster-name" {
  value = aws_ecs_cluster.cluster.name
}

output "cluster-arn" {
  value = aws_ecs_cluster.cluster.arn
}

output "task-definition-arn" {
  value = aws_ecs_task_definition.task.arn
}

output "subnet-ids" {
  value = var.subnet-ids
}

output "security-group-ids" {
  value = var.security-group-ids
}

output "execution-role-arn" {
  value = aws_iam_role.execution.arn
}

output "task-role-name" {
  value = aws_iam_role.task.name
}

output "task-role-arn" {
  value = aws_iam_role.task.arn
}
