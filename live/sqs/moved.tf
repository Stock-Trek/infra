moved {
  from = data.aws_iam_policy_document.send-message
  to   = data.aws_iam_policy_document.send_message
}

moved {
  from = aws_iam_policy.send-message
  to   = aws_iam_policy.send_message
}

moved {
  from = aws_iam_role_policy_attachment.send-message
  to   = aws_iam_role_policy_attachment.send_message
}

moved {
  from = aws_sqs_queue.dead-letter
  to   = aws_sqs_queue.dead_letter
}

moved {
  from = aws_sqs_queue_redrive_allow_policy.dead-letter
  to   = aws_sqs_queue_redrive_allow_policy.dead_letter
}
