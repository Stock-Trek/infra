locals {
  replica_name     = "${var.name}-replica"
  replication_name = "${var.name}-replication"

  replica_buckets = {
    replica      = aws_s3_bucket.replica.id
    replica_logs = aws_s3_bucket.replica_logs.id
  }
}
