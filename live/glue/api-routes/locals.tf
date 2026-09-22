locals {
  integration-type       = "AWS_PROXY"
  payload-format-version = "2.0"
  route_keys = var.routes == null ? tolist(["$default"]) : [
    for r in var.routes : "${r.method} ${r.path}"
  ]
}
