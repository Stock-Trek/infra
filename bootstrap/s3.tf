resource "aws_s3_bucket" "bootstrap" {
  bucket = "state.${local.bare_domain}"
}

resource "aws_s3_bucket" "bootstrap_logs" {
  bucket = "${aws_s3_bucket.bootstrap.bucket}-logs"
}

locals {
  primary_buckets = {
    bootstrap = {
      bucket_id   = aws_s3_bucket.bootstrap.id
      kms_key_arn = null
      mfa_delete  = "Disabled"
    }
    bootstrap_logs = {
      bucket_id   = aws_s3_bucket.bootstrap_logs.id
      kms_key_arn = data.aws_kms_alias.s3.target_key_arn
      mfa_delete  = "Disabled"
    }
  }
}

resource "aws_s3_bucket_notification" "primary" {
  for_each    = local.primary_buckets
  bucket      = each.value.bucket_id
  eventbridge = true
}

resource "aws_s3_bucket_lifecycle_configuration" "primary" {
  for_each = local.primary_buckets
  bucket   = each.value.bucket_id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

resource "aws_s3_bucket_public_access_block" "primary" {
  for_each                = local.primary_buckets
  bucket                  = each.value.bucket_id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "primary" {
  for_each = local.primary_buckets
  bucket   = each.value.bucket_id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
  depends_on = [aws_s3_bucket_public_access_block.primary]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "primary" {
  for_each = local.primary_buckets
  bucket   = each.value.bucket_id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = each.value.kms_key_arn
    }
    blocked_encryption_types = ["SSE-C"]
    bucket_key_enabled       = true
  }
}

resource "aws_s3_bucket_versioning" "primary" {
  for_each = local.primary_buckets
  bucket   = each.value.bucket_id
  versioning_configuration {
    mfa_delete = each.value.mfa_delete
    status     = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "bootstrap" {
  bucket        = aws_s3_bucket.bootstrap.id
  target_bucket = aws_s3_bucket.bootstrap_logs.id
  target_prefix = "logs/"
}

resource "aws_s3_bucket_policy" "bootstrap_logs" {
  bucket = aws_s3_bucket.bootstrap_logs.id
  policy = data.aws_iam_policy_document.logs.json
}
