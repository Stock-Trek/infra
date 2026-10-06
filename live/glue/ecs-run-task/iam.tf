resource "aws_iam_policy" "ecs-run-task" {
  name   = "${var.role}-ecs-run-task"
  policy = data.aws_iam_policy_document.ecs-run-task.json
}

resource "aws_iam_role_policy_attachment" "ecs-run-task" {
  role       = var.role
  policy_arn = aws_iam_policy.ecs-run-task.arn
}
