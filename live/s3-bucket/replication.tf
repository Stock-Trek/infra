resource "aws_s3_bucket" "replica" {
  provider = aws.replica
  bucket   = "${var.name}-replica"
  tags     = var.tags
}

resource "aws_s3_bucket_versioning" "replica" {
  provider = aws.replica
  bucket   = aws_s3_bucket.replica.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "replica" {
  provider                = aws.replica
  bucket                  = aws_s3_bucket.replica.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "replica" {
  provider = aws.replica
  bucket   = aws_s3_bucket.replica.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    blocked_encryption_types = ["SSE-C"]
  }
}

resource "aws_s3_bucket_notification" "replica" {
  provider    = aws.replica
  bucket      = aws_s3_bucket.replica.id
  eventbridge = true
}

resource "aws_s3_bucket_lifecycle_configuration" "replica" {
  provider = aws.replica
  bucket   = aws_s3_bucket.replica.id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
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
  name               = "${var.name}-replication"
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
    resources = ["${aws_s3_bucket.replica.arn}/*"]
  }
}

resource "aws_iam_role_policy" "replication" {
  name   = "${var.name}-replication"
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
    aws_s3_bucket_versioning.versioning,
    aws_s3_bucket_versioning.replica,
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
      bucket = aws_s3_bucket.replica.arn
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.logs,
    aws_s3_bucket_versioning.replica,
    aws_iam_role_policy.replication,
  ]
}
