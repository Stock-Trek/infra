resource "aws_iam_policy" "ec2-access" {
  name   = "${var.role}-ec2-access"
  policy = data.aws_iam_policy_document.ec2-access.json
}

resource "aws_iam_role_policy_attachment" "ec2-access" {
  role       = var.role
  policy_arn = aws_iam_policy.ec2-access.arn
}
