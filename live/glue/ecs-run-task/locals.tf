locals {
  task_definition_family_arn = replace(var.task_definition_arn, "/:[0-9]+$/", "")
}
