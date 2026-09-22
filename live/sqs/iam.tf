resource "aws_iam_policy" "send-message" {
  name   = "${var.role}-sqs-send-message"
  policy = data.aws_iam_policy_document.send-message.json
}

resource "aws_iam_role_policy_attachment" "send-message" {
  role       = var.role
  policy_arn = aws_iam_policy.send-message.arn
}
