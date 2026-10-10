moved {
  from = data.aws_iam_policy_document.s3-access
  to   = data.aws_iam_policy_document.s3_access
}

moved {
  from = aws_iam_policy.s3-access
  to   = aws_iam_policy.s3_access
}

moved {
  from = aws_iam_role_policy_attachment.s3-access
  to   = aws_iam_role_policy_attachment.s3_access
}
