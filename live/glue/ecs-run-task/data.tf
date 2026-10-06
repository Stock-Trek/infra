data "aws_iam_policy_document" "ecs-run-task" {
  statement {
    effect    = "Allow"
    actions   = ["ecs:RunTask"]
    resources = ["${local.task-definition-family-arn}:*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ecs:DescribeTasks"]
    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["iam:PassRole"]
    resources = [
      var.execution-role-arn,
      var.task-role-arn
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
  }
}
