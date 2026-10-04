data "aws_iam_policy_document" "ec2-access" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:RebootInstances",
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]
    resources = [var.instance-arn]
  }
}
