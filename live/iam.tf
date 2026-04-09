resource "aws_iam_role" "push_image" {
  name               = local.role_push_image
  assume_role_policy = data.aws_iam_policy_document.github_assume_web_identity.json
}

resource "aws_iam_policy" "push_image" {
  name   = "stock-trek-push-image"
  policy = data.aws_iam_policy_document.push_image.json
}

resource "aws_iam_role_policy_attachment" "push_image" {
  role       = aws_iam_role.push_image.name
  policy_arn = aws_iam_policy.push_image.arn
}
