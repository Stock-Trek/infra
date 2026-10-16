resource "aws_sns_topic" "alarms" {
  name              = var.name
  kms_master_key_id = var.kms_master_key_id
  tags              = var.tags
}

resource "aws_sns_topic_policy" "alarms" {
  arn    = aws_sns_topic.alarms.arn
  policy = data.aws_iam_policy_document.alarms.json
}

resource "aws_sns_topic_subscription" "email" {
  for_each = var.email_subscriptions

  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = each.value
}
