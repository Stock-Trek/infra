resource "aws_iam_role" "update" {
  name               = var.role-update
  assume_role_policy = data.aws_iam_policy_document.github-assume-web-identity.json
  tags               = var.tags
}

resource "aws_iam_policy" "update-image" {
  name   = "${aws_iam_role.update.name}-update-image"
  policy = data.aws_iam_policy_document.push-image.json
}

resource "aws_iam_role_policy_attachment" "update-image" {
  role       = aws_iam_role.update.name
  policy_arn = aws_iam_policy.update-image.arn
}
