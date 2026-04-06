# resource "aws_iam_role" "push_image" {
#   name               = "PushStockTrekImage"
#   assume_role_policy = data.aws_iam_policy_document.github_assume_web_identity.json
# }
# 
# resource "aws_iam_role" "run_lambda" {
#   name               = "RunStockTrekLambda"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }
# 
# resource "aws_iam_policy" "push_image" {
#   name   = "stock-trek-push-image"
#   policy = data.aws_iam_policy_document.push_image.json
# }
# 
# resource "aws_iam_policy" "pull_image" {
#   name   = "stock-trek-pull-image"
#   policy = data.aws_iam_policy_document.pull_image.json
# }
# 
# resource "aws_iam_policy" "logs" {
#   name   = "stock-trek-logs"
#   policy = data.aws_iam_policy_document.logs.json
# }
# 
# # TODO replace with database
# resource "aws_iam_policy" "read_write_s3" {
#   name   = "stock-trek-read-write-s3"
#   policy = data.aws_iam_policy_document.read_write_s3.json
# }
# 
# resource "aws_iam_role_policy_attachment" "push_image" {
#   role       = aws_iam_role.push_image.name
#   policy_arn = aws_iam_policy.push_image.arn
# }
# 
# resource "aws_iam_role_policy_attachment" "pull_image" {
#   role       = aws_iam_role.run_lambda.name
#   policy_arn = aws_iam_policy.pull_image.arn
# }
# 
# resource "aws_iam_role_policy_attachment" "logs" {
#   role       = aws_iam_role.run_lambda.name
#   policy_arn = aws_iam_policy.logs.arn
# }
# 
# # TODO replace with database
# resource "aws_iam_role_policy_attachment" "read_write_s3" {
#   role       = aws_iam_role.run_lambda.name
#   policy_arn = aws_iam_policy.read_write_s3.arn
# }
