moved {
  from = data.aws_iam_policy_document.s3-put
  to   = data.aws_iam_policy_document.s3_put
}

moved {
  from = aws_iam_policy.s3-put
  to   = aws_iam_policy.s3_put
}

moved {
  from = aws_iam_role_policy_attachment.s3-put
  to   = aws_iam_role_policy_attachment.s3_put
}
