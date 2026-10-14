# update
resource "aws_iam_role" "update" {
  name               = var.role_update
  assume_role_policy = data.aws_iam_policy_document.github_assume_web_identity.json
  tags               = var.tags
}

resource "aws_iam_policy" "update_lambda" {
  name   = "${aws_iam_role.update.name}-update-lambda"
  policy = data.aws_iam_policy_document.update_lambda.json
}

resource "aws_iam_role_policy_attachment" "update_lambda" {
  role       = aws_iam_role.update.name
  policy_arn = aws_iam_policy.update_lambda.arn
}

# run
resource "aws_iam_role" "run" {
  name               = local.role_run
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

resource "aws_iam_policy" "write_logs" {
  name   = "${aws_iam_role.run.name}-write-logs"
  policy = data.aws_iam_policy_document.write_logs.json
}

resource "aws_iam_role_policy_attachment" "write_logs" {
  role       = aws_iam_role.run.name
  policy_arn = aws_iam_policy.write_logs.arn
}

# vpc
resource "aws_iam_policy" "vpc_access" {
  count = local.vpc_count

  name   = "${aws_iam_role.run.name}-vpc-access"
  policy = data.aws_iam_policy_document.vpc_access.json
}

resource "aws_iam_role_policy_attachment" "vpc_access" {
  count = local.vpc_count

  role       = aws_iam_role.run.name
  policy_arn = aws_iam_policy.vpc_access[0].arn
}
