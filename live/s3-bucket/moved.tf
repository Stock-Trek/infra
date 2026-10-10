moved {
  from = data.aws_iam_policy_document.secure-transport
  to   = data.aws_iam_policy_document.secure_transport
}

moved {
  from = aws_s3_bucket_versioning.disable-versioning
  to   = aws_s3_bucket_versioning.disable_versioning
}

moved {
  from = aws_s3_bucket_policy.secure-transport-policy
  to   = aws_s3_bucket_policy.secure_transport_policy
}

moved {
  from = aws_s3_bucket_public_access_block.block-public-access
  to   = aws_s3_bucket_public_access_block.block_public_access
}
