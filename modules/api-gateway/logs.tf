resource "aws_cloudwatch_log_group" "access_logs" {
  name              = "/aws/apigateway/${var.name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = data.aws_kms_alias.logs.target_key_arn
  tags              = var.tags
}
