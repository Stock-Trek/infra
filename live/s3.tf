# S3 buckets for algorithm runner

resource "aws_s3_bucket" "uploaded_code" {
  bucket = "stock-trek-uploaded-code"
  
  tags = {
    Environment = "Production"
    Name        = "Uploaded Code Bucket"
  }
}

resource "aws_s3_bucket" "compiled_so" {
  bucket = "stock-trek-compiled-so"
  
  tags = {
    Environment = "Production"
    Name        = "Compiled .so Files Bucket"
  }
}

# Enable versioning for both buckets
resource "aws_s3_bucket_versioning" "uploaded_code" {
  bucket = aws_s3_bucket.uploaded_code.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "compiled_so" {
  bucket = aws_s3_bucket.compiled_so.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption for both buckets
resource "aws_s3_bucket_server_side_encryption_configuration" "uploaded_code" {
  bucket = aws_s3_bucket.uploaded_code.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "compiled_so" {
  bucket = aws_s3_bucket.compiled_so.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access for both buckets
resource "aws_s3_bucket_public_access_block" "uploaded_code" {
  bucket = aws_s3_bucket.uploaded_code.id
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "compiled_so" {
  bucket = aws_s3_bucket.compiled_so.id
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle rules for uploaded code bucket (keep versions for 30 days)
resource "aws_s3_bucket_lifecycle_configuration" "uploaded_code" {
  bucket = aws_s3_bucket.uploaded_code.id
  
  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"
    
    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

# Lifecycle rules for compiled .so bucket (keep versions for 90 days)
resource "aws_s3_bucket_lifecycle_configuration" "compiled_so" {
  bucket = aws_s3_bucket.compiled_so.id
  
  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"
    
    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}