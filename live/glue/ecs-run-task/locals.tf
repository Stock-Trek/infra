locals {
  task-definition-family-arn = replace(var.task-definition-arn, "/:[0-9]+$/", "")
}
