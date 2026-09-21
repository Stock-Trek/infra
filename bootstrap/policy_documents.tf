data "aws_iam_policy_document" "bootstrap_assume_role" {
  statement {
    sid    = "AssumeRoleGitHub"
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.bootstrap_github.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${local.oidc_github_bare_url}:aud"
      values   = local.oidc_github_audience
    }
    condition {
      test     = "StringLike"
      variable = "${local.oidc_github_bare_url}:sub"
      values   = local.oidc_github_subject
    }
  }
}
