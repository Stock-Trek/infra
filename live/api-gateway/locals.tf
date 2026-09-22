locals {
  protocol-type          = "HTTP"
  stage-name             = "$default"
  auto-deploy            = true
  integration-type       = "AWS_PROXY"
  payload-format-version = "2.0"

  cors-count          = var.cors == null ? 0 : 1
  cors-allow-headers  = ["*"]
  cors-allow-methods  = ["*"]
  cors-expose-headers = []
  cors-max-age        = 86400
}
