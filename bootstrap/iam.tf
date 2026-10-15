resource "aws_iam_role" "bootstrap_admin" {
  name               = "${local.bare_domain}-Terraform"
  description        = "Full access via GitHub"
  assume_role_policy = data.aws_iam_policy_document.bootstrap_assume_role.json
}

resource "aws_iam_role_policy_attachment" "bootstrap_admin" {
  role       = aws_iam_role.bootstrap_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "bootstrap_plan" {
  name               = "${local.bare_domain}-TerraformPlan"
  description        = "Read-only access via GitHub for Terraform plan"
  assume_role_policy = data.aws_iam_policy_document.bootstrap_assume_role.json
}

resource "aws_iam_role_policy_attachment" "bootstrap_plan" {
  role       = aws_iam_role.bootstrap_plan.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_policy" "bootstrap_plan_lock" {
  name   = "${aws_iam_role.bootstrap_plan.name}-lock"
  policy = data.aws_iam_policy_document.bootstrap_plan_lock.json
}

resource "aws_iam_role_policy_attachment" "bootstrap_plan_lock" {
  role       = aws_iam_role.bootstrap_plan.name
  policy_arn = aws_iam_policy.bootstrap_plan_lock.arn
}

resource "aws_iam_role" "bootstrap_apply" {
  name               = "${local.bare_domain}-TerraformApply"
  description        = "Full access via GitHub for Terraform apply"
  assume_role_policy = data.aws_iam_policy_document.bootstrap_assume_role.json
}

resource "aws_iam_role_policy_attachment" "bootstrap_apply" {
  role       = aws_iam_role.bootstrap_apply.name
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
