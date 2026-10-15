resource "aws_s3_bucket" "replica" {
  provider = aws.replica
  bucket   = local.replica_name
  tags     = var.tags
}

resource "aws_s3_bucket" "replica_logs" {
  provider = aws.replica
  bucket   = "${local.replica_name}-logs"
  tags     = var.tags
}

locals {
  replica_name = "${var.name}-replica"

  replica_buckets = {
    replica      = aws_s3_bucket.replica.id
    replica_logs = aws_s3_bucket.replica_logs.id
  }
}

resource "aws_s3_bucket_notification" "replica" {
  provider    = aws.replica
  for_each    = local.replica_buckets
  bucket      = each.value
  eventbridge = true
}

resource "aws_s3_bucket_lifecycle_configuration" "replica" {
  provider = aws.replica
  for_each = local.replica_buckets
  bucket   = each.value

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

resource "aws_s3_bucket_versioning" "replica" {
  provider = aws.replica
  for_each = local.replica_buckets
  bucket   = each.value
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "replica" {
  provider                = aws.replica
  for_each                = local.replica_buckets
  bucket                  = each.value
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "replica" {
  provider = aws.replica
  for_each = local.replica_buckets
  bucket   = each.value
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
  depends_on = [aws_s3_bucket_public_access_block.replica]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "replica" {
  provider = aws.replica
  for_each = local.replica_buckets
  bucket   = each.value
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    blocked_encryption_types = ["SSE-C"]
    bucket_key_enabled       = var.bucket_key_enabled
  }
}

data "aws_iam_policy_document" "replica_logs" {
  statement {
    sid    = "S3ServerAccessLogs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.replica_logs.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.replica.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "replica_logs" {
  provider = aws.replica
  bucket   = aws_s3_bucket.replica_logs.id
  policy   = data.aws_iam_policy_document.replica_logs.json
}

resource "aws_s3_bucket_logging" "replica" {
  provider      = aws.replica
  bucket        = aws_s3_bucket.replica.id
  target_bucket = aws_s3_bucket.replica_logs.id
  target_prefix = "logs/"
}

data "aws_iam_policy_document" "replication_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "replication" {
  name               = coalesce(var.replication_role_name, "${var.name}-replication")
  assume_role_policy = data.aws_iam_policy_document.replication_assume_role.json
  tags               = var.tags
}

data "aws_iam_policy_document" "replication" {
  statement {
    sid    = "SourceBuckets"
    effect = "Allow"
    actions = [
      "s3:GetBucketVersioning",
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.bucket.arn,
      aws_s3_bucket.logs.arn,
    ]
  }

  statement {
    sid    = "SourceObjects"
    effect = "Allow"
    actions = [
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionTagging",
    ]
    resources = [
      "${aws_s3_bucket.bucket.arn}/*",
      "${aws_s3_bucket.logs.arn}/*",
    ]
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
    resources = [
      "${aws_s3_bucket.replica.arn}/*",
      "${aws_s3_bucket.replica_logs.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "replication" {
  name   = coalesce(var.replication_role_name, "${var.name}-replication")
  role   = aws_iam_role.replication.id
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_s3_bucket_replication_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  role   = aws_iam_role.replication.arn

  rule {
    id     = "replicate"
    status = "Enabled"

    destination {
      bucket = aws_s3_bucket.replica.arn
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.primary["bucket"],
    aws_s3_bucket_versioning.replica["replica"],
    aws_iam_role_policy.replication,
  ]
}

resource "aws_s3_bucket_replication_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id
  role   = aws_iam_role.replication.arn

  rule {
    id     = "replicate"
    status = "Enabled"

    destination {
      bucket = aws_s3_bucket.replica_logs.arn
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.primary["logs"],
    aws_s3_bucket_versioning.replica["replica_logs"],
    aws_iam_role_policy.replication,
  ]
}
