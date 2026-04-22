data "aws_iam_policy_document" "s3-access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = var.bucket-arns
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [for bucket-arn in var.bucket-arns : "${bucket-arn}/*"]
  }
}
