data "aws_iam_policy_document" "update-code" {
  count = local.zip-count

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

resource "aws_iam_policy" "update-code" {
  count = local.zip-count

  name   = "${aws_iam_role.update.name}-update-code"
  policy = data.aws_iam_policy_document.update-code[0].json
}

resource "aws_iam_role_policy_attachment" "update-code" {
  count = local.zip-count

  role       = aws_iam_role.update.name
  policy_arn = aws_iam_policy.update-code[0].arn
}
