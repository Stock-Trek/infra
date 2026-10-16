data "aws_region" "current" {}

data "aws_kms_alias" "logs" {
  name = "alias/aws/logs"
}
