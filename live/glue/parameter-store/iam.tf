# Write access for GitHub OIDC (master branch of specific repo)
resource "aws_iam_policy" "parameter-store-write" {
  name   = "parameter-store-write-${replace(var.prefix, "/", "-")}"
  policy = data.aws_iam_policy_document.parameter-store-write.json
}

resource "aws_iam_role" "parameter-store-write" {
  name               = "ParameterStoreWrite-${replace(var.prefix, "/", "-")}"
  assume_role_policy = data.aws_iam_policy_document.github-assume-web-identity.json
}

resource "aws_iam_role_policy_attachment" "parameter-store-write" {
  role       = aws_iam_role.parameter-store-write.name
  policy_arn = aws_iam_policy.parameter-store-write.arn
}

# Read access for lambda
resource "aws_iam_policy" "parameter-store-read" {
  name   = "parameter-store-read-${replace(var.prefix, "/", "-")}"
  policy = data.aws_iam_policy_document.parameter-store-read.json
}

resource "aws_iam_role_policy_attachment" "parameter-store-read" {
  role       = var.lambda-role-name
  policy_arn = aws_iam_policy.parameter-store-read.arn
}
