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

  role                           = aws_iam_role.run.arn
  architectures                  = ["x86_64"]
  memory_size                    = var.memory
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions
  code_signing_config_arn        = aws_lambda_code_signing_config.lambda.arn
  kms_key_arn                    = data.aws_kms_alias.lambda.target_key_arn
  environment {
    variables = var.env_vars
  }
  dynamic "vpc_config" {
    for_each = local.vpc_count == 1 ? [true] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }
  tags = var.tags
  depends_on = [
    aws_iam_role_policy_attachment.write_logs,
    aws_iam_role_policy_attachment.vpc_access,
    docker_registry_image.dummy[0],
    data.archive_file.dummy[0],
  ]
  lifecycle {
    precondition {
      condition     = local.vpc_count == 0 || (length(var.security_group_ids) > 0 && var.vpc_id != null)
      error_message = "security_group_ids and vpc_id must be set when subnet_ids is set."
    }
    ignore_changes = [
      filename,
      source_code_hash,
      image_uri,
    ]
  }
}
