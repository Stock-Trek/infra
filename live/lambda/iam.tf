# update
resource "aws_iam_role" "update" {
  name               = var.role-update-code
  assume_role_policy = data.aws_iam_policy_document.github-assume-web-identity.json
}

resource "aws_iam_policy" "update-code" {
  name   = "${aws_iam_role.update.name}-update-code"
  policy = data.aws_iam_policy_document.update-code.json
}

resource "aws_iam_role_policy_attachment" "update-code" {
  role       = aws_iam_role.update.name
  policy_arn = aws_iam_policy.update-code.arn
}


# run
resource "aws_iam_role" "run" {
  name               = local.role-run
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_policy" "write-logs" {
  name   = "${aws_iam_role.run.name}-write-logs"
  policy = data.aws_iam_policy_document.write-logs.json
}

resource "aws_iam_role_policy_attachment" "write-logs" {
  role       = aws_iam_role.run.name
  policy_arn = aws_iam_policy.write-logs.arn
}
