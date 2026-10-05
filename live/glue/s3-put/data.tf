data "aws_iam_policy_document" "s3-put" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${var.bucket-arn}/${local.prefix}*"]
  }
}
