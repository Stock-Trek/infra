moved {
  from = aws_s3_bucket.bootstrap
  to   = module.bucket_bootstrap.aws_s3_bucket.bucket
}

moved {
  from = aws_s3_bucket.bootstrap_logs
  to   = module.bucket_bootstrap.aws_s3_bucket.logs
}

moved {
  from = aws_s3_bucket_notification.primary["bootstrap"]
  to   = module.bucket_bootstrap.aws_s3_bucket_notification.primary["bucket"]
}

moved {
  from = aws_s3_bucket_notification.primary["bootstrap_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_notification.primary["logs"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.primary["bootstrap"]
  to   = module.bucket_bootstrap.aws_s3_bucket_lifecycle_configuration.primary["bucket"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.primary["bootstrap_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_lifecycle_configuration.primary["logs"]
}

moved {
  from = aws_s3_bucket_versioning.primary["bootstrap"]
  to   = module.bucket_bootstrap.aws_s3_bucket_versioning.primary["bucket"]
}

moved {
  from = aws_s3_bucket_versioning.primary["bootstrap_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_versioning.primary["logs"]
}

moved {
  from = aws_s3_bucket_public_access_block.primary["bootstrap"]
  to   = module.bucket_bootstrap.aws_s3_bucket_public_access_block.primary["bucket"]
}

moved {
  from = aws_s3_bucket_public_access_block.primary["bootstrap_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_public_access_block.primary["logs"]
}

moved {
  from = aws_s3_bucket_ownership_controls.primary["bootstrap"]
  to   = module.bucket_bootstrap.aws_s3_bucket_ownership_controls.primary["bucket"]
}

moved {
  from = aws_s3_bucket_ownership_controls.primary["bootstrap_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_ownership_controls.primary["logs"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.primary["bootstrap"]
  to   = module.bucket_bootstrap.aws_s3_bucket_server_side_encryption_configuration.primary["bucket"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.primary["bootstrap_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_server_side_encryption_configuration.primary["logs"]
}

moved {
  from = aws_s3_bucket_logging.bootstrap
  to   = module.bucket_bootstrap.aws_s3_bucket_logging.access_logging
}

moved {
  from = aws_s3_bucket_policy.bootstrap_logs
  to   = module.bucket_bootstrap.aws_s3_bucket_policy.logs
}

moved {
  from = aws_s3_bucket.bootstrap_replica
  to   = module.bucket_bootstrap.aws_s3_bucket.replica
}

moved {
  from = aws_s3_bucket.bootstrap_replica_logs
  to   = module.bucket_bootstrap.aws_s3_bucket.replica_logs
}

moved {
  from = aws_s3_bucket_notification.replica["bootstrap_replica"]
  to   = module.bucket_bootstrap.aws_s3_bucket_notification.replica["replica"]
}

moved {
  from = aws_s3_bucket_notification.replica["bootstrap_replica_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_notification.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.replica["bootstrap_replica"]
  to   = module.bucket_bootstrap.aws_s3_bucket_lifecycle_configuration.replica["replica"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.replica["bootstrap_replica_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_lifecycle_configuration.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_versioning.replica["bootstrap_replica"]
  to   = module.bucket_bootstrap.aws_s3_bucket_versioning.replica["replica"]
}

moved {
  from = aws_s3_bucket_versioning.replica["bootstrap_replica_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_versioning.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_public_access_block.replica["bootstrap_replica"]
  to   = module.bucket_bootstrap.aws_s3_bucket_public_access_block.replica["replica"]
}

moved {
  from = aws_s3_bucket_public_access_block.replica["bootstrap_replica_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_public_access_block.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_ownership_controls.replica["bootstrap_replica"]
  to   = module.bucket_bootstrap.aws_s3_bucket_ownership_controls.replica["replica"]
}

moved {
  from = aws_s3_bucket_ownership_controls.replica["bootstrap_replica_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_ownership_controls.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.replica["bootstrap_replica"]
  to   = module.bucket_bootstrap.aws_s3_bucket_server_side_encryption_configuration.replica["replica"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.replica["bootstrap_replica_logs"]
  to   = module.bucket_bootstrap.aws_s3_bucket_server_side_encryption_configuration.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_policy.bootstrap_replica_logs
  to   = module.bucket_bootstrap.aws_s3_bucket_policy.replica_logs
}

moved {
  from = aws_s3_bucket_logging.bootstrap_replica
  to   = module.bucket_bootstrap.aws_s3_bucket_logging.replica
}

moved {
  from = aws_iam_role.bootstrap_replication
  to   = module.bucket_bootstrap.aws_iam_role.replication
}

moved {
  from = aws_iam_role_policy.bootstrap_replication
  to   = module.bucket_bootstrap.aws_iam_role_policy.replication
}

moved {
  from = aws_s3_bucket_replication_configuration.bootstrap
  to   = module.bucket_bootstrap.aws_s3_bucket_replication_configuration.bucket
}

moved {
  from = aws_s3_bucket_replication_configuration.bootstrap_logs
  to   = module.bucket_bootstrap.aws_s3_bucket_replication_configuration.logs
}
