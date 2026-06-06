data "aws_iam_policy_document" "github-assume-web-identity" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [var.github-oidc-arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github-account}/${var.repo-name}:ref:refs/heads/master"]
    }
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
      "arn:aws:ssm:*:*:parameter/${local.prefix}/*",
      "arn:aws:ssm:*:*:parameter/${local.prefix}"
    ]
  }
}

data "aws_iam_policy_document" "parameter-store-write" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:PutParameter",
      "ssm:DeleteParameter",
      "ssm:DeleteParameters"
    ]
    resources = [
      "arn:aws:ssm:*:*:parameter/${local.prefix}/*",
      "arn:aws:ssm:*:*:parameter/${local.prefix}"
    ]
  }
}
