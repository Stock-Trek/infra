# Push images

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

resource "aws_iam_policy" "update_lambda_code" {
  name   = "stock-trek-update-lambda-code"
  policy = data.aws_iam_policy_document.update_lambda.json
}

resource "aws_iam_role_policy_attachment" "update_lambda_code" {
  role       = aws_iam_role.push_image.name
  policy_arn = aws_iam_policy.update_lambda_code.arn
}


# Run lambda

resource "aws_iam_role" "run_lambda" {
  name               = local.role_run_lambda
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "pull_image" {
  name   = "stock-trek-pull-image"
  policy = data.aws_iam_policy_document.pull_image.json
}

resource "aws_iam_policy" "logs" {
  name   = "stock-trek-logs"
  policy = data.aws_iam_policy_document.logs.json
}

resource "aws_iam_role_policy_attachment" "pull_image" {
  role       = aws_iam_role.run_lambda.name
  policy_arn = aws_iam_policy.pull_image.arn
}

resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.run_lambda.name
  policy_arn = aws_iam_policy.logs.arn
}

resource "aws_iam_policy" "s3_access" {
  name   = "stock-trek-s3-access"
  policy = data.aws_iam_policy_document.s3_access.json
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.run_lambda.name
  policy_arn = aws_iam_policy.s3_access.arn
}
