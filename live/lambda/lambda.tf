resource "aws_lambda_function" "lambda" {
  function_name = var.name
  package_type  = var.package-type

  # Image
  image_uri = try(local.package-config.image_uri, null)
  image_config {
    command           = try(local.package-config.image_config.command, null)
    entry_point       = try(local.package-config.image_config.entry_point, null)
    working_directory = try(local.package-config.image_config.working_directory, null)
  }

  # Zip
  filename         = try(local.package-config.filename, null)
  handler          = try(local.package-config.handler, null)
  runtime          = try(local.package-config.runtime, null)
  source_code_hash = try(local.package-config.source_code_hash, null)

  role          = aws_iam_role.run.arn
  architectures = ["x86_64"]
  memory_size   = var.memory
  timeout       = var.timeout
  environment {
    variables = var.env-vars
  }
  tags = var.tags
  depends_on = [
    aws_iam_role_policy_attachment.write-logs,
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
