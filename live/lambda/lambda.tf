resource "aws_lambda_function" "lambda" {
  function_name = var.name
  package_type  = var.package_type

  # Image
  image_uri = try(local.package_config.image_uri, null)

  # Zip
  filename         = try(local.package_config.filename, null)
  handler          = try(local.package_config.handler, null)
  runtime          = try(local.package_config.runtime, null)
  source_code_hash = try(local.package_config.source_code_hash, null)

  role                    = aws_iam_role.run.arn
  architectures           = ["x86_64"]
  memory_size             = var.memory
  timeout                 = var.timeout
  code_signing_config_arn = aws_lambda_code_signing_config.lambda.arn
  environment {
    variables = var.env_vars
  }
  tags = var.tags
  depends_on = [
    aws_iam_role_policy_attachment.write_logs,
    docker_registry_image.dummy[0],
    data.archive_file.dummy[0],
  ]
  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash,
      image_uri,
    ]
  }
}
