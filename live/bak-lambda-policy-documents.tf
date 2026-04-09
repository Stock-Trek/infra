# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "sts:AssumeRole"
#     ]
#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }
#   }
# }
# 
# data "aws_iam_policy_document" "logs" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents"
#     ]
#     resources = ["*"]
#   }
# }
# 
# data "aws_iam_policy_document" "pull_image" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "ecr:GetAuthorizationToken",
#       "ecr:BatchGetImage",
#       "ecr:GetDownloadUrlForLayer"
#     ]
#     resources = ["*"]
#   }
# }
# 
# # TODO replace with database
# data "aws_iam_policy_document" "read_write_s3" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:GetObject",
#       "s3:PutObject",
#       "s3:ListBucket"
#     ]
#     resources = ["*"]
#   }
# }
