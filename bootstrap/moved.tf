moved {
  from = aws_s3_bucket_notification.bootstrap
  to   = aws_s3_bucket_notification.primary["bootstrap"]
}

moved {
  from = aws_s3_bucket_notification.bootstrap_logs
  to   = aws_s3_bucket_notification.primary["bootstrap_logs"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.bootstrap
  to   = aws_s3_bucket_lifecycle_configuration.primary["bootstrap"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.bootstrap_logs
  to   = aws_s3_bucket_lifecycle_configuration.primary["bootstrap_logs"]
}

moved {
  from = aws_s3_bucket_public_access_block.bootstrap
  to   = aws_s3_bucket_public_access_block.primary["bootstrap"]
}

moved {
  from = aws_s3_bucket_public_access_block.bootstrap_logs
  to   = aws_s3_bucket_public_access_block.primary["bootstrap_logs"]
}

moved {
  from = aws_s3_bucket_ownership_controls.bootstrap
  to   = aws_s3_bucket_ownership_controls.primary["bootstrap"]
}

moved {
  from = aws_s3_bucket_ownership_controls.bootstrap_logs
  to   = aws_s3_bucket_ownership_controls.primary["bootstrap_logs"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.bootstrap
  to   = aws_s3_bucket_server_side_encryption_configuration.primary["bootstrap"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.bootstrap_logs
  to   = aws_s3_bucket_server_side_encryption_configuration.primary["bootstrap_logs"]
}

moved {
  from = aws_s3_bucket_versioning.bootstrap
  to   = aws_s3_bucket_versioning.primary["bootstrap"]
}

moved {
  from = aws_s3_bucket_versioning.bootstrap_logs
  to   = aws_s3_bucket_versioning.primary["bootstrap_logs"]
}

moved {
  from = aws_s3_bucket_notification.bootstrap_replica
  to   = aws_s3_bucket_notification.replica["bootstrap_replica"]
}

moved {
  from = aws_s3_bucket_notification.bootstrap_replica_logs
  to   = aws_s3_bucket_notification.replica["bootstrap_replica_logs"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.bootstrap_replica
  to   = aws_s3_bucket_lifecycle_configuration.replica["bootstrap_replica"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.bootstrap_replica_logs
  to   = aws_s3_bucket_lifecycle_configuration.replica["bootstrap_replica_logs"]
}

moved {
  from = aws_s3_bucket_public_access_block.bootstrap_replica
  to   = aws_s3_bucket_public_access_block.replica["bootstrap_replica"]
}

moved {
  from = aws_s3_bucket_public_access_block.bootstrap_replica_logs
  to   = aws_s3_bucket_public_access_block.replica["bootstrap_replica_logs"]
}

moved {
  from = aws_s3_bucket_ownership_controls.bootstrap_replica
  to   = aws_s3_bucket_ownership_controls.replica["bootstrap_replica"]
}

moved {
  from = aws_s3_bucket_ownership_controls.bootstrap_replica_logs
  to   = aws_s3_bucket_ownership_controls.replica["bootstrap_replica_logs"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.bootstrap_replica
  to   = aws_s3_bucket_server_side_encryption_configuration.replica["bootstrap_replica"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.bootstrap_replica_logs
  to   = aws_s3_bucket_server_side_encryption_configuration.replica["bootstrap_replica_logs"]
}

moved {
  from = aws_s3_bucket_versioning.bootstrap_replica
  to   = aws_s3_bucket_versioning.replica["bootstrap_replica"]
}

moved {
  from = aws_s3_bucket_versioning.bootstrap_replica_logs
  to   = aws_s3_bucket_versioning.replica["bootstrap_replica_logs"]
}
