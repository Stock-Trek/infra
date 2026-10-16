data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  aws_logs_kms_arn = "arn:aws:kms:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:alias/aws/logs"
}
