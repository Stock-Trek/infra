data "aws_guardduty_detector" "current" {}

module "guardduty" {
  source      = "./guardduty"
  detector-id = data.aws_guardduty_detector.current.id
}
