resource "aws_guardduty_detector_feature" "runtime-monitoring" {
  detector_id = var.detector-id
  name        = "RUNTIME_MONITORING"
  status      = "ENABLED"

  additional_configuration {
    name   = "ECS_FARGATE_AGENT_MANAGEMENT"
    status = "ENABLED"
  }
}
