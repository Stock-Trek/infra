resource "aws_cloudwatch_log_group" "flow_logs" {
  name              = "/aws/vpc/flow-logs/${var.name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = data.aws_kms_alias.logs.target_key_arn
  tags              = var.tags
}

resource "aws_flow_log" "this" {
  vpc_id               = aws_vpc.vpc.id
  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.flow_logs.arn
  iam_role_arn         = aws_iam_role.flow_logs.arn
  tags                 = var.tags
}
