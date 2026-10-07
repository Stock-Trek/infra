output "cluster-arn" {
  value = aws_ecs_cluster.cluster.arn
}

output "cluster-name" {
  value = aws_ecs_cluster.cluster.name
}

output "container-name" {
  value = var.name
}

output "execution-role-arn" {
  value = aws_iam_role.execution.arn
}

output "security-group-ids" {
  value = var.security-group-ids
}

output "subnet-ids" {
  value = var.subnet-ids
}

output "task-definition-arn" {
  value = aws_ecs_task_definition.task.arn
}

output "task-role-arn" {
  value = aws_iam_role.task.arn
}

output "task-role-name" {
  value = aws_iam_role.task.name
}
