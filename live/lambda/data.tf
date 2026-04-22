resource "null_resource" "trigger" {}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/dummy_bootstrap.zip"
  source {
    content  = "#!/bin/bash\nexit 0"
    filename = "bootstrap"
  }
  depends_on = [null_resource.trigger]
}

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
      values   = ["repo:${var.github-account}/*:*"]
    }
  }
}

data "aws_iam_policy_document" "update-code" {
  statement {
    effect = "Allow"
    actions = [
      "lambda:GetFunction",
      "lambda:PublishVersion",
      "lambda:UpdateFunctionCode"
    ]
    resources = [aws_lambda_function.lambda.arn]
  }
}

data "aws_iam_policy_document" "write-logs" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
