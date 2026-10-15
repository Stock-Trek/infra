moved {
  from = aws_s3_bucket_notification.bucket
  to   = aws_s3_bucket_notification.primary["bucket"]
}

moved {
  from = aws_s3_bucket_notification.logs
  to   = aws_s3_bucket_notification.primary["logs"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.bucket
  to   = aws_s3_bucket_lifecycle_configuration.primary["bucket"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.logs
  to   = aws_s3_bucket_lifecycle_configuration.primary["logs"]
}

moved {
  from = aws_s3_bucket_versioning.versioning
  to   = aws_s3_bucket_versioning.primary["bucket"]
}

moved {
  from = aws_s3_bucket_versioning.logs
  to   = aws_s3_bucket_versioning.primary["logs"]
}

moved {
  from = aws_s3_bucket_public_access_block.block_public_access
  to   = aws_s3_bucket_public_access_block.primary["bucket"]
}

moved {
  from = aws_s3_bucket_public_access_block.logs
  to   = aws_s3_bucket_public_access_block.primary["logs"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.encrypt
  to   = aws_s3_bucket_server_side_encryption_configuration.primary["bucket"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.logs
  to   = aws_s3_bucket_server_side_encryption_configuration.primary["logs"]
}

moved {
  from = aws_s3_bucket_notification.replica
  to   = aws_s3_bucket_notification.replica["replica"]
}

moved {
  from = aws_s3_bucket_notification.replica_logs
  to   = aws_s3_bucket_notification.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.replica
  to   = aws_s3_bucket_lifecycle_configuration.replica["replica"]
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.replica_logs
  to   = aws_s3_bucket_lifecycle_configuration.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_versioning.replica
  to   = aws_s3_bucket_versioning.replica["replica"]
}

moved {
  from = aws_s3_bucket_versioning.replica_logs
  to   = aws_s3_bucket_versioning.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_public_access_block.replica
  to   = aws_s3_bucket_public_access_block.replica["replica"]
}

moved {
  from = aws_s3_bucket_public_access_block.replica_logs
  to   = aws_s3_bucket_public_access_block.replica["replica_logs"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.replica
  to   = aws_s3_bucket_server_side_encryption_configuration.replica["replica"]
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.replica_logs
  to   = aws_s3_bucket_server_side_encryption_configuration.replica["replica_logs"]
}
