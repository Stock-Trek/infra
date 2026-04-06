resource "aws_iam_role" "bootstrap_admin" {
  name               = "${local.bare_domain}-Terraform"
  description        = "Full access via GitHub"
  assume_role_policy = data.aws_iam_policy_document.bootstrap_assume_role.json
}

resource "aws_iam_role_policy_attachment" "bootstrap_admin" {
  role       = aws_iam_role.bootstrap_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "bootstrap_reader" {
  name = "${local.bare_domain}-Reader"
}

resource "aws_iam_user_policy_attachment" "bootstrap_reader" {
  user       = aws_iam_user.bootstrap_reader.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_access_key" "bootstrap_reader" {
  user = aws_iam_user.bootstrap_reader.name
}
