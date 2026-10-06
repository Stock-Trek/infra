data "aws_iam_policy_document" "push-image" {
  count = local.image-count

  statement {
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = [var.image.ecr-repository-arn]
  }
}

data "aws_iam_policy_document" "pull-image" {
  count = local.image-count

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
    resources = [var.image.ecr-repository-arn]
  }
}

resource "aws_iam_policy" "push-image" {
  count = local.image-count

  name   = "${aws_iam_role.update.name}-push-image"
  policy = data.aws_iam_policy_document.push-image[0].json
}

resource "aws_iam_role_policy_attachment" "push-image" {
  count = local.image-count

  role       = aws_iam_role.update.name
  policy_arn = aws_iam_policy.push-image[0].arn
}

resource "aws_iam_policy" "pull-image" {
  count = local.image-count

  name   = "${aws_iam_role.run.name}-pull-image"
  policy = data.aws_iam_policy_document.pull-image[0].json
}

resource "aws_iam_role_policy_attachment" "pull-image" {
  count = local.image-count

  role       = aws_iam_role.run.name
  policy_arn = aws_iam_policy.pull-image[0].arn
}
