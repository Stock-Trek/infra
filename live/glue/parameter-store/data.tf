data "aws_iam_policy_document" "parameter-store-write" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:PutParameter",
      "ssm:DeleteParameter",
      "ssm:DeleteParameters"
    ]
    resources = [
      "arn:aws:ssm:*:*:parameter${var.prefix}/*",
      "arn:aws:ssm:*:*:parameter${var.prefix}"
    ]
  }
}

data "aws_iam_policy_document" "parameter-store-read" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    resources = [
      "arn:aws:ssm:*:*:parameter${var.prefix}/*",
      "arn:aws:ssm:*:*:parameter${var.prefix}"
    ]
  }
}
