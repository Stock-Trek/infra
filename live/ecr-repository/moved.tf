moved {
  from = data.aws_iam_policy_document.github-assume-web-identity
  to   = data.aws_iam_policy_document.github_assume_web_identity
}

moved {
  from = data.aws_iam_policy_document.push-image
  to   = data.aws_iam_policy_document.push_image
}

moved {
  from = aws_ecr_lifecycle_policy.remove-untagged
  to   = aws_ecr_lifecycle_policy.remove_untagged
}

moved {
  from = aws_iam_policy.update-image
  to   = aws_iam_policy.update_image
}

moved {
  from = aws_iam_role_policy_attachment.update-image
  to   = aws_iam_role_policy_attachment.update_image
}
