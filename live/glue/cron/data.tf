data "aws_iam_policy_document" "assume_role" {
  statement {
    sid    = "AssumeRole"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
