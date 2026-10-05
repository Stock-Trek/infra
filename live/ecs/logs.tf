resource "aws_cloudwatch_log_group" "logs" {
  name              = "/ecs/${var.name}"
  retention_in_days = var.log-retention-days
  tags              = var.tags
}
