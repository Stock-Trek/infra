moved {
  from = data.aws_iam_policy_document.github-assume-web-identity
  to   = data.aws_iam_policy_document.github_assume_web_identity
}

moved {
  from = data.aws_iam_policy_document.parameter-store-read
  to   = data.aws_iam_policy_document.parameter_store_read
}

moved {
  from = data.aws_iam_policy_document.parameter-store-write
  to   = data.aws_iam_policy_document.parameter_store_write
}

moved {
  from = aws_iam_role.parameter-store-write
  to   = aws_iam_role.parameter_store_write
}

moved {
  from = aws_iam_policy.parameter-store-read
  to   = aws_iam_policy.parameter_store_read
}

moved {
  from = aws_iam_policy.parameter-store-write
  to   = aws_iam_policy.parameter_store_write
}

moved {
  from = aws_iam_role_policy_attachment.parameter-store-read
  to   = aws_iam_role_policy_attachment.parameter_store_read
}

moved {
  from = aws_iam_role_policy_attachment.parameter-store-write
  to   = aws_iam_role_policy_attachment.parameter_store_write
}
