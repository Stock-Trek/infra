resource "aws_s3_bucket" "buckets" {
  for_each = local.s3_buckets
  
  bucket = each.value
  
  tags = {
    Environment = "Production"
    Name        = each.key == "uploaded_code" ? "Uploaded Code Bucket" : "Compiled .so Files Bucket"
  }
}

resource "aws_s3_bucket_versioning" "buckets" {
  for_each = local.s3_buckets
  
  bucket = aws_s3_bucket.buckets[each.key].id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_policy" "buckets" {
  for_each = local.s3_buckets
  
  bucket = aws_s3_bucket.buckets[each.key].id
  policy = data.aws_iam_policy_document.bucket_policies[each.key].json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "buckets" {
  for_each = local.s3_buckets
  
  bucket = aws_s3_bucket.buckets[each.key].id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "buckets" {
  for_each = local.s3_buckets
  
  bucket = aws_s3_bucket.buckets[each.key].id
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}