moved {
  from = data.aws_iam_policy_document.dlq-write
  to   = data.aws_iam_policy_document.dlq_write
}

moved {
  from = aws_iam_policy.dlq-write
  to   = aws_iam_policy.dlq_write
}

moved {
  from = aws_iam_role_policy_attachment.dlq-write
  to   = aws_iam_role_policy_attachment.dlq_write
}
