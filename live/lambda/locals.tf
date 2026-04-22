locals {
  public-count = (var.public-access-cors-bare-domain == null ? 0 : 1)
  role-run     = "${var.name}-run"
}
