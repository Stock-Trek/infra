resource "aws_s3_bucket" "bootstrap" {
  bucket = "state.${local.bare_domain}"
}

resource "aws_s3_bucket_lifecycle_configuration" "bootstrap" {
  bucket = aws_s3_bucket.bootstrap.id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

resource "aws_s3_bucket_notification" "bootstrap" {
  bucket      = aws_s3_bucket.bootstrap.id
  eventbridge = true
}

resource "aws_s3_bucket_public_access_block" "bootstrap" {
  bucket                  = aws_s3_bucket.bootstrap.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "bootstrap" {
  bucket = aws_s3_bucket.bootstrap.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bootstrap" {
  bucket = aws_s3_bucket.bootstrap.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    blocked_encryption_types = ["SSE-C"]
    bucket_key_enabled       = true
  }
}

resource "aws_s3_bucket_versioning" "bootstrap" {
  bucket = aws_s3_bucket.bootstrap.id
  versioning_configuration {
    mfa_delete = "Disabled"
    status     = "Enabled"
  }
}

resource "aws_s3_bucket" "bootstrap_logs" {
  bucket = "${aws_s3_bucket.bootstrap.bucket}-logs"
}

resource "aws_s3_bucket_logging" "bootstrap" {
  bucket        = aws_s3_bucket.bootstrap.id
  target_bucket = aws_s3_bucket.bootstrap_logs.id
  target_prefix = "logs/"
}

resource "aws_s3_bucket_notification" "bootstrap_logs" {
  bucket      = aws_s3_bucket.bootstrap_logs.id
  eventbridge = true
}

resource "aws_s3_bucket_lifecycle_configuration" "bootstrap_logs" {
  bucket = aws_s3_bucket.bootstrap_logs.id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

resource "aws_s3_bucket_versioning" "bootstrap_logs" {
  bucket = aws_s3_bucket.bootstrap_logs.id
  versioning_configuration {
    mfa_delete = "Disabled"
    status     = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "bootstrap_logs" {
  bucket = aws_s3_bucket.bootstrap_logs.id
  policy = data.aws_iam_policy_document.logs.json
}

resource "aws_s3_bucket_public_access_block" "bootstrap_logs" {
  bucket                  = aws_s3_bucket.bootstrap_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "bootstrap_logs" {
  bucket = aws_s3_bucket.bootstrap_logs.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bootstrap_logs" {
  bucket = aws_s3_bucket.bootstrap_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = data.aws_kms_alias.s3.target_key_arn
    }
    blocked_encryption_types = ["SSE-C"]
    bucket_key_enabled       = true
  }
}
