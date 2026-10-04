locals {
  registry = split("/", var.image.repository-url)[0]
}
