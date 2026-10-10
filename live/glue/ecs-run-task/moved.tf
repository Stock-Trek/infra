moved {
  from = data.aws_iam_policy_document.ecs-run-task
  to   = data.aws_iam_policy_document.ecs_run_task
}

moved {
  from = aws_iam_policy.ecs-run-task
  to   = aws_iam_policy.ecs_run_task
}

moved {
  from = aws_iam_role_policy_attachment.ecs-run-task
  to   = aws_iam_role_policy_attachment.ecs_run_task
}
