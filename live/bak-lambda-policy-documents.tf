# data "aws_iam_policy_document" "github_assume_web_identity" {
#   statement {
#     effect = "Allow"
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     principals {
#       type        = "Federated"
#       identifiers = [data.aws_iam_openid_connect_provider.github.arn]
#     }
#     condition {
#       test     = "StringEquals"
#       variable = "token.actions.githubusercontent.com:aud"
#       values   = ["sts.amazonaws.com"]
#     }
#     condition {
#       test     = "StringLike"
#       variable = "token.actions.githubusercontent.com:sub"
#       values   = ["repo:${local.github_account_name}/${local.github_repository_name}:*"]
#     }
#   }
# }
# 
# data "aws_iam_policy_document" "push_image" {
#   statement {
#     effect    = "Allow"
#     actions  = ["ecr:GetAuthorizationToken"]
#     resources = ["*"]
#   }
#   statement {
#     effect = "Allow"
#     actions = [
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:BatchGetImage",
#       "ecr:CompleteLayerUpload",
#       "ecr:InitiateLayerUpload",
#       "ecr:PutImage",
#       "ecr:UploadLayerPart"
#     ]
#     resources = [
#       aws_ecr_repository.stock_trek.arn
#     ]
#   }
#   statement {
#     effect = "Allow"
#     actions = [
#       "lambda:UpdateFunctionCode"
#     ]
#     resources = [
#       aws_lambda_function.lambda.arn
#     ]
#   }
# }
# 
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
