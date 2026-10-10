moved {
  from = data.aws_iam_policy_document.github-assume-web-identity
  to   = data.aws_iam_policy_document.github_assume_web_identity
}

moved {
  from = data.aws_iam_policy_document.update-lambda
  to   = data.aws_iam_policy_document.update_lambda
}

moved {
  from = data.aws_iam_policy_document.assume-role
  to   = data.aws_iam_policy_document.assume_role
}

moved {
  from = data.aws_iam_policy_document.write-logs
  to   = data.aws_iam_policy_document.write_logs
}

moved {
  from = aws_iam_policy.update-lambda
  to   = aws_iam_policy.update_lambda
}

moved {
  from = aws_iam_role_policy_attachment.update-lambda
  to   = aws_iam_role_policy_attachment.update_lambda
}

moved {
  from = aws_iam_policy.write-logs
  to   = aws_iam_policy.write_logs
}

moved {
  from = aws_iam_role_policy_attachment.write-logs
  to   = aws_iam_role_policy_attachment.write_logs
}

moved {
  from = data.aws_iam_policy_document.push-image
  to   = data.aws_iam_policy_document.push_image
}

moved {
  from = data.aws_iam_policy_document.pull-image
  to   = data.aws_iam_policy_document.pull_image
}

moved {
  from = aws_iam_policy.push-image
  to   = aws_iam_policy.push_image
}

moved {
  from = aws_iam_role_policy_attachment.push-image
  to   = aws_iam_role_policy_attachment.push_image
}

moved {
  from = aws_iam_policy.pull-image
  to   = aws_iam_policy.pull_image
}

moved {
  from = aws_iam_role_policy_attachment.pull-image
  to   = aws_iam_role_policy_attachment.pull_image
}

moved {
  from = aws_lambda_function_url.public-url
  to   = aws_lambda_function_url.public_url
}

moved {
  from = aws_lambda_permission.allow-invoking
  to   = aws_lambda_permission.allow_invoking
}

moved {
  from = aws_lambda_permission.allow-public-access
  to   = aws_lambda_permission.allow_public_access
}
