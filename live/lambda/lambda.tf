resource "aws_lambda_function" "lambda" {
  function_name    = var.name
  package_type     = "Zip"
  handler          = "bootstrap"
  filename         = data.archive_file.dummy.output_path
  source_code_hash = data.archive_file.dummy.output_base64sha256
  runtime          = "provided.al2023"
  role             = aws_iam_role.run.arn
  publish          = true
  architectures    = ["x86_64"]
  memory_size      = var.memory
  timeout          = var.timeout
  tags             = var.tags
  depends_on       = [aws_iam_role_policy_attachment.write-logs]
  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash,
    ]
  }
}
