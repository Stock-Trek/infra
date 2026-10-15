resource "aws_s3_bucket" "bootstrap_replica" {
  provider = aws.replica
  bucket   = "state-replica.${local.bare_domain}"
}

resource "aws_s3_bucket_public_access_block" "bootstrap_replica" {
  provider                = aws.replica
  bucket                  = aws_s3_bucket.bootstrap_replica.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "bootstrap_replica" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bootstrap_replica" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    blocked_encryption_types = ["SSE-C"]
    bucket_key_enabled       = true
  }
}

resource "aws_s3_bucket_versioning" "bootstrap_replica" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_notification" "bootstrap_replica" {
  provider    = aws.replica
  bucket      = aws_s3_bucket.bootstrap_replica.id
  eventbridge = true
}

resource "aws_s3_bucket_lifecycle_configuration" "bootstrap_replica" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica.id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

resource "aws_s3_bucket" "bootstrap_replica_logs" {
  provider = aws.replica
  bucket   = "${aws_s3_bucket.bootstrap_replica.bucket}-logs"
}

resource "aws_s3_bucket_notification" "bootstrap_replica_logs" {
  provider    = aws.replica
  bucket      = aws_s3_bucket.bootstrap_replica_logs.id
  eventbridge = true
}

resource "aws_s3_bucket_lifecycle_configuration" "bootstrap_replica_logs" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica_logs.id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

resource "aws_s3_bucket_versioning" "bootstrap_replica_logs" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica_logs.id
  versioning_configuration {
    mfa_delete = "Disabled"
    status     = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "bootstrap_replica_logs" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica_logs.id
  policy   = data.aws_iam_policy_document.bootstrap_replica_logs.json
}

resource "aws_s3_bucket_public_access_block" "bootstrap_replica_logs" {
  provider                = aws.replica
  bucket                  = aws_s3_bucket.bootstrap_replica_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "bootstrap_replica_logs" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica_logs.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bootstrap_replica_logs" {
  provider = aws.replica
  bucket   = aws_s3_bucket.bootstrap_replica_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    blocked_encryption_types = ["SSE-C"]
    bucket_key_enabled       = true
  }
}

resource "aws_s3_bucket_logging" "bootstrap_replica" {
  provider      = aws.replica
  bucket        = aws_s3_bucket.bootstrap_replica.id
  target_bucket = aws_s3_bucket.bootstrap_replica_logs.id
  target_prefix = "logs/"
}

data "aws_iam_policy_document" "bootstrap_replication_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "bootstrap_replication" {
  name               = "${local.bare_domain}-BootstrapReplication"
  assume_role_policy = data.aws_iam_policy_document.bootstrap_replication_assume_role.json
}

data "aws_iam_policy_document" "bootstrap_replication" {
  statement {
    sid    = "SourceBucket"
    effect = "Allow"
    actions = [
      "s3:GetBucketVersioning",
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]
    resources = [aws_s3_bucket.bootstrap.arn]
  }

  statement {
    sid    = "SourceObjects"
    effect = "Allow"
    actions = [
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionTagging",
    ]
    resources = ["${aws_s3_bucket.bootstrap.arn}/*"]
  }

  statement {
    sid    = "DestinationObjects"
    effect = "Allow"
    actions = [
      "s3:ObjectOwnerOverrideToBucketOwner",
      "s3:ReplicateDelete",
      "s3:ReplicateObject",
      "s3:ReplicateTags",
    ]
    resources = ["${aws_s3_bucket.bootstrap_replica.arn}/*"]
  }
}

resource "aws_iam_role_policy" "bootstrap_replication" {
  name   = "${local.bare_domain}-BootstrapReplication"
  role   = aws_iam_role.bootstrap_replication.id
  policy = data.aws_iam_policy_document.bootstrap_replication.json
}

resource "aws_s3_bucket_replication_configuration" "bootstrap" {
  bucket = aws_s3_bucket.bootstrap.id
  role   = aws_iam_role.bootstrap_replication.arn

  rule {
    id     = "replicate"
    status = "Enabled"

    destination {
      bucket = aws_s3_bucket.bootstrap_replica.arn
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.bootstrap,
    aws_s3_bucket_versioning.bootstrap_replica,
    aws_iam_role_policy.bootstrap_replication,
  ]
}
