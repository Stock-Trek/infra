resource "aws_iam_policy" "s3-access" {
  name   = "${var.role}-s3-access"
  policy = data.aws_iam_policy_document.s3-access.json
}

resource "aws_iam_role_policy_attachment" "s3-access" {
  role       = var.role
  policy_arn = aws_iam_policy.s3-access.arn
}
