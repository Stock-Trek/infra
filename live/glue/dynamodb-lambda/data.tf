data "aws_iam_policy_document" "consume" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"
    ]
    resources = [
      var.stream-arn,
      "${var.stream-arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "dlq-write" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${var.dlq-bucket-arn}/*"]
  }
}
