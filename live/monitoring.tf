module "monitoring" {
  source              = "../modules/monitoring"
  name                = local.monitoring_topic_name
  email_subscriptions = local.monitoring_email_subscriptions
  tags                = local.tags
}
