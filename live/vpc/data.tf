data "aws_region" "current" {}

data "aws_kms_alias" "logs" {
  name = "alias/aws/logs"
}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}
